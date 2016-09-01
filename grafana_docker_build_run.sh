#!/bin/sh

GRAFANA_VERSION="v3.0.5"

docker build -t nneves-grafana:$GRAFANA_VERSION .

docker run \
-e PORT=3000 \
-p 3000:3000 \
-v /Users/nelson/work/Babl/babl-grafana/grafana_ini:/etc/grafana/ \
-v /Users/nelson/work/Babl/babl-grafana/grafana_db:/var/lib/grafana \
nneves-grafana:$GRAFANA_VERSION