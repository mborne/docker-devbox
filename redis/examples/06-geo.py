from db import r

r.geoadd("villes", (2.3522, 48.8566, "Paris"), (4.8357, 45.7640, "Lyon"))
print(r.georadius("villes", 2.35, 48.85, 400, unit="km"))

