# MailHog

Container running running [MailHog](https://github.com/mailhog/MailHog#readme) to test email sending from applications.

## Alternative

> **WARNING** : [Mailhog is no longer maintained](https://github.com/mailhog/MailHog/issues/442#issuecomment-1493415258)

* [Mailpit](../mailpit/README.md)

## Usage with docker

* Start mailhog : `docker compose up -d`

* Send an email : `telnet localhost 1025`

```bash
HELO mailhog.devbox
MAIL FROM: <test@mailhog.devbox>
RCPT TO: <test@example.com>
DATA
Reply-to: noreply@mailhog.devbox
Subject: test email
this is a test email
.
quit
```

* Open http://mailhog.dev.localhost or http://mailhog.dev.localhost/api/v2/messages

![Test email](doc/test-email.png)
