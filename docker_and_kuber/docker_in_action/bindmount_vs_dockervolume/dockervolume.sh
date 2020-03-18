docker volume create \
    --driver local \
    logging-example

docker run --name plath -d \
    --mount type=volume,src=logging-example,dst=/data \
    dockerinaction/ch4_writer_a

docker run --rm \
    --mount type=volume,src=logging-example,dst=/data \
    alpine:latest \
    head /data/logA

cat "$(docker volume inspect logging-example \
    --format "{{.Mountpoint}}")"/logA

docker stop plath
