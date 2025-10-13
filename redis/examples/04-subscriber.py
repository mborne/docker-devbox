from db import r

pubsub = r.pubsub()
pubsub.subscribe("news")

print("Listening 'news'...")
for message in pubsub.listen():
    if message["type"] == "message":
        print("📢", message["data"])
