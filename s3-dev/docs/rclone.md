# Using S3 with rclone

## Configure S3 remote

Use `rclone config file` to locate and fill config file with :

```ini
[s3-dev]
type = s3
provider = Other
access_key_id = s3_dev_key_id
secret_access_key = ChangeItToAStrongKey
endpoint = http://s3.dev.localhost/
# acl = private
# bucket_acl = private
```

## Some rclone commands

| Description                          | Command                              |
| ------------------------------------ | ------------------------------------ |
| List rclone remotes                  | `rclone listremotes`                 |
| List buckets                         | `rclone lsd s3-dev:`                 |
| Create bucket                        | `rclone mkdir s3-dev:images`         |
| Synchronize remote folder with local | `rclone sync ~/Images s3-dev:images` |





