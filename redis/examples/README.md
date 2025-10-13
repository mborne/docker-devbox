# redis-examples

Some usage examples in Python to discover its features.

## Requirements

* [uv (Python)](https://docs.astral.sh/uv/guides/install-python/)

## Examples

* [db.py](db.py) handles parameters and provides redis client instance as "r"
* [01-string.py](01-string.py) - [String](https://redis.io/docs/latest/develop/data-types/strings/) - `SET`, `GET`, `SETNX`, `INCR`, `EXPIRE`

```bash
uv run 01-string.py
```

* [02-hash.py](02-hash.py) - [Hashes](https://redis.io/docs/latest/develop/data-types/hashes/) - `HGET`, `HGETALL`, `HINCRBY`, `HEXPIRE`
* [03-list-push.py](03-list-push.py) / [03-list-pop.py](03-list-pop.py) - [Lists](https://redis.io/docs/latest/develop/data-types/lists/) - `RPUSH`, `BLPOP`, `LLEN`
* [04-publisher.py](04-publisher.py) / [04-subscriber.py](04-subscriber.py) - [Pub/Sub](https://redis.io/docs/latest/develop/pubsub/)
* [05-producer.py](05-producer.py) / [05-consumer.py](05-consumer.py) - [Streams](https://redis.io/docs/latest/develop/data-types/streams/)
* [06-geo.py](06-geo.py) - [Geo](https://redis.io/docs/latest/commands/?group=geo)
* [07-pydantic.py](07-pydantic.py) - pydantic / JSON storage
