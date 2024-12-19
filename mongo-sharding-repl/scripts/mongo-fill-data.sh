#!/bin/bash

###
# Инициализируем бд
###

docker compose exec -T mongos_router mongosh --port 27021 --quiet <<EOF
use somedb
for(var i = 0; i < 1000; i++) db.helloDoc.insertOne({age:i, name:"ly"+i})
EOF
