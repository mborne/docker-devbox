# Using MinIO S3 object storage in a PHP Symfony project

This page explains how to configure [flysystem-bundle](https://github.com/thephpleague/flysystem-bundle) use [Flysystem](https://flysystem.thephpleague.com/docs/) to ease migration from a local / NFS storage to an S3 object storage.

## Dependencies

```bash
composer require league/flysystem-bundle
composer require league/flysystem-async-aws-s3
```

## Configuration

* `config/packages/flysystem.yaml` with a local storage and an S3 storage :

```yaml
services:
    s3_client:
        class: 'AsyncAws\S3\S3Client'
        arguments:
            -  endpoint: '%env(S3_ENDPOINT)%'
               accessKeyId: '%env(S3_ACCESS_KEY)%'
               accessKeySecret: '%env(S3_SECRET_KEY)%'
               # required for minio (avoids access to {bucket}.minio-s3.dev.localhost)
               pathStyleEndpoint: true

flysystem:
    storages:
        default.storage:
            adapter: 'local'
            options:
                directory: '%kernel.project_dir%/var/data'
        data.storage:
            adapter: 'asyncaws'
            options:
                client: 's3_client'
                bucket: '%env(S3_BUCKET_DATA)%'
```

with the following content in `.env` :

```yaml
S3_ENDPOINT=https://minio-s3.dev.localhost
S3_ACCESS_KEY=ToBeConfigured
S3_SECRET_KEY=ToBeConfigured

S3_BUCKET_DATA=qtw-data
```

* `config/packages/test/flysystem.yaml` - to use only local storage for tests

```yaml
flysystem:
    storages:
        default.storage:
            adapter: 'local'
            options:
                directory: '%kernel.project_dir%/var/data'
        data.storage:
            adapter: 'local'
            options:
                directory: '%kernel.project_dir%/tests/DATA'
```

## Usage

Use dependency injection with `FilesystemOperator $defaultStorage` and `FilesystemOperator $dataStorage`.

For example in a controller displaying markdown  (https://www.quadtreeworld.net/data/) :

```php
<?php

namespace App\Controller;

use App\Filesystem\dataStorage;
use App\Helper\Strings;
use League\Flysystem\FilesystemOperator;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\HttpFoundation\StreamedResponse;
use Symfony\Component\Routing\Annotation\Route;

/**
 * Exploration du système de fichier dataStorage avec
 * rendu des markdown.
 */
class DataController extends AbstractController
{
    /**
     * @Route("/data/{path}", name="data_get", requirements={"path"=".*"})
     */
    public function getAction(
        FilesystemOperator $dataStorage,
        string $path = ''
    ): Response {
        if (!empty($path) && !$dataStorage->has($path)) {
            throw $this->createNotFoundException(sprintf("'%s' not found", $path));
        }

        if ($dataStorage->directoryExists($path)) {
            $items = $dataStorage->listContents($path);

            return $this->render('data/list.html.twig', [
                'path' => $path,
                'items' => $items,
            ]);
        } elseif (Strings::endsWith($path, '.md')) {
            $markdownContent = $dataStorage->read($path);
            $parsedown = new \Parsedown();
            $content = $parsedown->text($markdownContent);

            return $this->render('data/markdown.html.twig', [
                'path' => $path,
                'parentPath' => Strings::parentPath($path),
                'content' => $content,
            ]);
        } else {
            $stream = $dataStorage->readStream($path);
            $response = new StreamedResponse();
            $response->headers->set('Content-Type', ''.$dataStorage->mimeType($path));
            $response->headers->set('Content-Length', ''.$dataStorage->fileSize($path));
            $response->setCallback(function () use ($stream) {
                if (0 !== ftell($stream)) {
                    rewind($stream);
                }
                fpassthru($stream);
                fclose($stream);
            });

            return $response;
        }
    }
}
```

## Resources

* [Utiliser MinIO comme stockage de données objets en PHP](https://www.jdecool.fr/blog/2020/07/07/utiliser-minio-comme-stockage-de-donnees-objets-en-php.html)
