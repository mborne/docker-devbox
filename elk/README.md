
# ELK

## Description

Docker containers running elasticsearch and kibana

## Usage

* Start elasticsearch and kibana : `docker-compose up -d`

* Open following URLs

| Service       | Direct                | Traefik                 |
|---------------|-----------------------|-------------------------|
| Kibana        | http://localhost:5601 | http://kibana.localhost |
| ElasticSearch | http://localhost:9200 | http://es.localhost     |
