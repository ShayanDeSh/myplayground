#!/bin/bash

mkdir logfiles

sudo chown 2000:2000 logfiles

docker container run --rm -v "$(pwd)"/logfiles:/logfiles \
    -u 2000:2000 ubuntu:16.04 \
    /bin/bash -c "echo loging the log > /logfiles/important.log"

docker container run --rm -v "$(pwd)"/logfiles:/logfiles \
    -u 2000:2000 ubuntu:16.04 \
    /bin/bash -c "echo loging other log >> /logfiles/important.log"

