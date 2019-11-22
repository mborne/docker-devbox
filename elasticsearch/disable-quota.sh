#!/bin/bash

HOST_HOSTNAME=${HOST_HOSTNAME:-localhost}

curl -X PUT "http://es.${HOST_HOSTNAME}/_cluster/settings" -H 'Content-Type: application/json' -d'
{
    "transient": {
    "cluster.routing.allocation.disk.watermark.low": "30mb",
    "cluster.routing.allocation.disk.watermark.high": "20mb",
    "cluster.routing.allocation.disk.watermark.flood_stage": "10mb",
    "cluster.info.update.interval": "1m"
    }
}
'

curl -XPUT -H "Content-Type: application/json" http://es.${HOST_HOSTNAME}/_all/_settings -d '{"index.blocks.read_only_allow_delete": null}'
