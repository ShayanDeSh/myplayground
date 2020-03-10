docker service update \
    --image dockerinaction/ch11_service_hw:v2 \
    --update-order stop-first \
    --update-parallelism 1 \
    --update-delay 30s \
    hello_world

