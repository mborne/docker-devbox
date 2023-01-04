# MinIO

Container running [MinIO](https://min.io/) offering S3 compatible object storage.

## Usage with docker

* Start containers : `MINIO_ROOT_PASSWORD=ChangeIt docker compose up -d`
* Open https://minio.dev.localhost/
* Use https://minio-s3.dev.localhost as an S3 endpoint

## Usage with Kubernetes

> Based on [Bitnami Object Storage based on MinIO® helm charts](https://bitnami.com/stack/minio/helm)

* Configure default admin password

```bash
export MINIO_ROOT_PASSWORD=ChangeIt
```

* Read [k8s-install.sh](k8s-install.sh) and run :

```bash
# To get dashboard on https://minio.dev.localhost
bash k8s-install.sh
# To get dashboard on https://minio.example.net
DEVBOX_HOSTNAME=example.net bash k8s-install.sh
```

* Wait for pods to be ready : `kubectl -n minio-system get pods -w`
* Open dashboard on https://minio.dev.localhost/minio
* Use https://minio-s3.dev.localhost as an S3 endpoint

## Resources

Docker :

* [www.sefidian.com - Deploy Standalone (Single Node) MinIO server using Docker Compose on Linux](http://www.sefidian.com/2022/04/08/deploy-standalone-minio-using-docker-compose/)

Kubernetes :

* [github.com - bitnami/charts - MinIO](https://github.com/bitnami/charts/tree/main/bitnami/minio/#readme)

Client usage :

* [Using MinIO with rclone](rclone.md)
* [Using MinIO S3 object storage in a PHP Symfony project](flysystem-bundle.md)
* [www.jdecool.fr - Utiliser MinIO comme stockage de données objets en PHP](https://www.jdecool.fr/blog/2020/07/07/utiliser-minio-comme-stockage-de-donnees-objets-en-php.html)

