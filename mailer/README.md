# mailer

Container running [namshi/smtp](https://hub.docker.com/r/namshi/smtp) which is a SMTP relay.

> **Warning:** See [namshi/smtp -tags](https://hub.docker.com/r/namshi/smtp/tags) currently displaying **Last pushed 3 years ago by namshi**.

## Usage with docker

* Create `config.env` file to provide `GMAIL_USER` and `GMAIL_PASSWORD`

> See [config.env.dist](config.env.dist) or [namshi/smtp on dockerhub](https://hub.docker.com/r/namshi/smtp)

* Start container : `docker compose up -d`

* Configure other tools to use `mailer:25` to send mails.

## Testing

* [mediatemple.net - Sending or viewing emails using telnet](https://mediatemple.net/community/products/dv/204404584/sending-or-viewing-emails-using-telnet)


