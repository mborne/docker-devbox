# max_map_count - minimal value for ElasticSearch and OpenSearch

You may have to increase the value of `max_map_count` on Docker host :

```bash
sudo sysctl -w vm.max_map_count=262144
# edit /etc/sysctl.conf to make it permanent
```

