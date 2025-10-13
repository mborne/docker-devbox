import redis

r = redis.Redis(host='localhost', port=6379, decode_responses=True)

if __name__ == '__main__':
    print("Connexion OK :", r.ping())

