# redis

Container running [redis](https://redis.io/).

## Usage with docker

* Start : `REDIS_PASSWORD=ChangeIt docker compose up -d`
* Note that redis is exposed on port 6379
* Test with embedded redis-cli : `docker exec -ti redis redis-cli`

```
127.0.0.1:6379> ping
PONG
127.0.0.1:6379> set mykey somevalue
OK
127.0.0.1:6379> get mykey
"somevalue"
127.0.0.1:6379> quit
```


## Resources

* [redis.io - Documentation](https://redis.io/docs/) which includes [Getting started with Redis](https://redis.io/docs/getting-started/)
* [redis.io - Commands](https://redis.io/commands/)
* [geshan.com.np - Using Redis with docker and docker-compose for local development a step-by-step tutorial](https://geshan.com.np/blog/2022/01/redis-docker/)


Client usage with PHP :

* [phpredis/phpredis - PHP Session handler](https://github.com/phpredis/phpredis#php-session-handler)
* [symfony.com - Store Sessions in a key-value Database (Redis)](https://symfony.com/doc/current/session.html#store-sessions-in-a-key-value-database-redis)

