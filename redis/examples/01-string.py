from db import r

# https://redis.io/docs/latest/develop/data-types/strings/

# stockage clé/valeur simple
r.set("username", "alice")
print("username: ", r.get("username"))

# comptage du nombre d'exécution
r.setnx("visites",0) # inutile
r.incr("visites")
print("visites: ", r.get("visites"))

# note : incrby possible

# reset 
r.expire("visites", 10)
