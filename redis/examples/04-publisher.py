import time
from db import r

while True:
    msg = input("Message à publier : ")
    r.publish("news", msg)
