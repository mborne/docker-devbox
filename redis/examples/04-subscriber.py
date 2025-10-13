from db import r

pubsub = r.pubsub()
pubsub.subscribe("news")

print("En écoute sur 'news'...")
for message in pubsub.listen():
    if message["type"] == "message":
        print("📢", message["data"])
