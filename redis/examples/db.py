import redis
import os

REDIS_HOST=os.getenv('REDIS_HOST','localhost')
REDIS_PORT=int(os.getenv('REDIS_HOST',6379))
REDIS_DB=int(os.getenv('REDIS_DB',0))
REDIS_PASSWORD=os.getenv('REDIS_PASSWORD',None)

if REDIS_PASSWORD is None:
    r = redis.Redis(host=REDIS_HOST, port=REDIS_PORT, db=REDIS_DB, decode_responses=True)
else:
    r = redis.StrictRedis(host=REDIS_HOST, port=REDIS_PORT, db=REDIS_DB, password=REDIS_PASSWORD, decode_responses=True)

if __name__ == '__main__':
    print("Connexion OK :", r.ping())

