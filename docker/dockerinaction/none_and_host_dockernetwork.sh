#!/bin/bash

# host network

echo --------------- host network ----------------

docker run --rm \
    --network host \
    alpine:3.8 ip -o addr

echo --------------- none network ----------------

# none network
docker run --rm \
    --network none \
    alpine:3.8 ip -o addr
