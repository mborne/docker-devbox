
# ElasticSearch - troubleshooting with docker-compose

```bash
docker-compose logs -f
```

### vm.max_map_count too low

> [1]: max virtual memory areas vm.max_map_count [65530] is too low, increase to at least [262144]

```bash
sudo sysctl -w vm.max_map_count=262144
```

### Disable disk quota / watermark

```bash
bash disable-quota.sh
```
