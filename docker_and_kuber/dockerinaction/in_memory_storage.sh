docker run --rm \
    --mount type=tmpfs,dst=/tmp,tmpfs-size=16k,tmpfs-mode=1770 \
    --entrypoint mount \
    alpine:latest -v
