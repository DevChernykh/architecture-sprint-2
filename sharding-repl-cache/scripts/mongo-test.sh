#!/bin/bash

set -e

docker compose exec -T mongos_router mongosh --port 27021 --quiet <<EOF
use somedb
db.helloDoc.getShardDistribution()
EOF

docker compose exec -T mongo-shard-1 mongosh --port 27017 --quiet <<EOF
rs.status()
EOF

docker compose exec -T mongo-shard-2 mongosh --port 27017 --quiet <<EOF
rs.status()
EOF