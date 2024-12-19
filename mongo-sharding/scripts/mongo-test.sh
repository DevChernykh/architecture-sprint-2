#!/bin/bash

docker compose exec -T mongos_router mongosh --port 27021 --quiet <<EOF
use somedb
db.helloDoc.getShardDistribution()
EOF
