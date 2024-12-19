#!/bin/bash

set -e

docker compose exec -T configSrv mongosh --port 27017 --quiet <<EOF
rs.initiate(
  {
    _id: "config_server",
    configsvr: true,
    members: [
      { _id: 0, host: "configSrv:27017" }
    ]
  }
)
EOF

docker compose exec -T mongo-shard-1 mongosh --port 27017 --quiet <<EOF
rs.initiate(
  {
    _id: "shard1",
    members: [
      { _id: 0, host: "mongo-shard-1:27017" }
    ]
  }
)

rs.add("mongo-shard-1-replica-1:27017")
rs.add("mongo-shard-1-replica-2:27017")
rs.add("mongo-shard-1-replica-3:27017")
EOF

docker compose exec -T mongo-shard-2 mongosh --port 27017 --quiet <<EOF
rs.initiate(
  {
    _id: "shard2",
    members: [
      { _id: 0, host: "mongo-shard-2:27017" }
    ]
  }
)

rs.add("mongo-shard-2-replica-1:27017")
rs.add("mongo-shard-2-replica-2:27017")
rs.add("mongo-shard-2-replica-3:27017")
EOF

docker compose exec -T mongos_router mongosh --port 27021 --quiet <<EOF
sh.addShard("shard1/mongo-shard-1:27017");
sh.addShard("shard2/mongo-shard-2:27017");

sh.enableSharding("somedb");
sh.shardCollection("somedb.helloDoc", { "name": "hashed" });
EOF
