# Using MinIO with rclone

## Config

* Create an "access key" / "secret key" pair ( https://minio.dev.localhost/access-keys )
* Configure a `minio-dev` in `~/.config/rclone/rclone.conf` :

```ini
[minio-dev]
type = s3
provider = Minio
access_key_id = TheAccessKey
secret_access_key = TheSecretKey
endpoint = https://minio-s3.dev.localhost
#acl = private
#bucket_acl = private
```

## Some rclone commands

| Description                          | Command                                 |
| ------------------------------------ | --------------------------------------- |
| List rclone remotes                  | `rclone listremotes`                    |
| List buckets                         | `rclone lsd minio-dev:`                 |
| Create bucket                        | `rclone mkdir minio-dev:images`         |
| Synchronize remote folder with local | `rclone sync ~/Images minio-dev:images` |





