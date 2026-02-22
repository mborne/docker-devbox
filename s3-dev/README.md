# s3-dev

Container running [rclone serve s3](https://rclone.org/commands/rclone_serve_s3/) to provide a S3 implementation for DEV purpose.

## Usage with Docker

```bash
# configure credentials
export S3_DEV_ACCESS_KEY_ID=s3_dev_key_id
export S3_DEV_SECRET_ACCESS_KEY=ChangeItToAStrongKey

# start S3 server
docker compose up -d
```

## Client usage

* [Using S3 with rclone](docs/rclone.md)
* [Using S3 object storage in a PHP Symfony project](docs/flysystem-bundle.md)


## Resources

* [rclone.org - rclone serve s3 - supported operations](https://rclone.org/commands/rclone_serve_s3/#supported-operations)
