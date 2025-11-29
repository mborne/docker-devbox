from db import r

# https://redis.io/docs/latest/develop/data-types/strings/

# store and retreive values
r.set("username", "alice")
print("username: ", r.get("username"))

# count number of visites
r.setnx("visites",0) # useless as incr sets values to 0 if not exists
r.incr("visites")
print("visites: ", r.get("visites"))

# note : incrby possible

# remove visites counter after 10 seconds
r.expire("visites", 10)


