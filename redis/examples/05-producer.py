import time
from db import r

for i in range(5):
    r.xadd("logs", {"type": "test","event": f"message {i}"})
    time.sleep(1)
