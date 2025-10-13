from db import r

for i in range(10000):
    r.sadd("visiteurs:set", f"user{i}")
    r.pfadd("visiteurs:hll", f"user{i}")

print("Set exact :", r.scard("visiteurs:set"))
print("HLL estimé :", r.pfcount("visiteurs:hll"))