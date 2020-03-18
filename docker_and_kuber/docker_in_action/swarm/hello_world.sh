docker service create \
    --publish 8080:80 \
    --name hello_world \
    dockerinaction/ch11_service_hw:v1
