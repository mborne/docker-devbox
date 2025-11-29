import signal
from db import r
import time

run = True

# handle CTRL+C
def handler_stop_signals(signum, frame):
    global run
    print("SIGTERM received, shuting down...")
    run = False

signal.signal(signal.SIGINT, handler_stop_signals)
signal.signal(signal.SIGTERM, handler_stop_signals)

while run:
    print("Waiting for tasks...")
    task = r.blpop("queue:tasks")
    print("Process task :", task)
    time.sleep(3)
    print("Nombre restant : ", r.llen('queue:tasks'))
