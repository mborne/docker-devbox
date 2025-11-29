from db import r

last_id = "0-0"
while True:
    events = r.xread({"logs": last_id}, block=0, count=1)
    for stream, msgs in events:
        for msg_id, data in msgs:
            print("📥", msg_id, data)
            last_id = msg_id
