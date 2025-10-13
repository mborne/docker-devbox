# https://redis.io/docs/latest/develop/data-types/hashes/

from db import r

r.hset("user:1", mapping={"username": "jdoe", "birth_date": "1984-01-01"})
active = False
if r.hget("user:1","visite") is not None:
    active = True

print("Active : ", active)
r.hincrby("user:1", "visite", 1)
r.hexpire("user:1", 5, "visite")

print("Name :", r.hget("user:1","username"))
print("User : ", r.hgetall("user:1"))

