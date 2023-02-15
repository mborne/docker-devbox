#!/bin/bash

ES_URL=${ES_URL:-http://localhost:9200}

echo ""
curl -X PUT "${ES_URL}/_cluster/settings" -H 'Content-Type: application/json' -d'
{
    "transient": {
    "cluster.routing.allocation.disk.watermark.low": "30mb",
    "cluster.routing.allocation.disk.watermark.high": "20mb",
    "cluster.routing.allocation.disk.watermark.flood_stage": "10mb",
    "cluster.info.update.interval": "1m"
    }
}
'
echo ""
curl -XPUT -H "Content-Type: application/json" "${ES_URL}/_all/_settings" -d '{"index.blocks.read_only_allow_delete": null}'
echo ""

