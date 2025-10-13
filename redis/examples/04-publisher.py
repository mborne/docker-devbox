from db import r

while True:
    msg = input("Input message : ")
    r.publish("news", msg)
