#!/bin/sh

GRAFANA_VERSION="v3.1.1-1"

docker build -t babl-grafana:$GRAFANA_VERSION .

docker run \
-e PORT=3000 \
-p 3000:3000 \
-v $PWD/grafana_ini:/etc/grafana/ \
-v $PWD/grafana_db:/var/lib/grafana \
babl-grafana:$GRAFANA_VERSION