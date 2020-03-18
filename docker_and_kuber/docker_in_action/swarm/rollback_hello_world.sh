docker service update \
    --image dockerinaction/ch11_service_hw:start-failure \
    --update-failure-action rollback \
    --update-max-failure-ratio 0.6 \
    hello_world
