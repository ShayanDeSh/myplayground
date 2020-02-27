#!/bin/bash

docker container run -d -u nobody --name ch6_ipc_producer \
    --ipc shareable \
    dockerinaction/ch6_ipc -producer

docker container run -d -u nobody --name ch6_ipc_consumer \
    --ipc container:ch6_ipc_producer \
    dockerinaction/ch6_ipc -consumer

docker logs ch6_ipc_producer

docker logs ch6_ipc_consumer
