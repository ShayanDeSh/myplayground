#!/bin/bash

docker network create \
    --driver bridge \
    --label project=learnindockernetwork \
    --label subject=network \
    --attachable \
    --scope local \
    --subnet 10.0.43.0/24 \
    --ip-range 10.0.43.128/25 \
    user-network2
