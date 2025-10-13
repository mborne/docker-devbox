import signal

from db import r

run = True

def handler_stop_signals(signum, frame):
    global run
    run = False

signal.signal(signal.SIGINT, handler_stop_signals)
signal.signal(signal.SIGTERM, handler_stop_signals)

while run:
    # prompt for new task
    content = input("Enter task :")
    if content is not None and content != "":
        r.rpush("queue:taches", content)
