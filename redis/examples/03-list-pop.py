import signal
from db import r
import time

run = True

def handler_stop_signals(signum, frame):
    global run
    print("SIGTERM received, shuting down...")
    run = False

signal.signal(signal.SIGINT, handler_stop_signals)
signal.signal(signal.SIGTERM, handler_stop_signals)

while run:
    print("En attente de tâche...")
    tache = r.blpop("queue:taches")
    print("Traitement :", tache)
    time.sleep(3)
    print("Nombre restant : ", r.llen('queue:taches'))
