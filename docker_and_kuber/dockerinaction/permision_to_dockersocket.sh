#!/bin/bash
docker container run --rm -v /var/run/docker.sock:/var/run/docker.sock:ro \
    -u root monitoringtool # Some monitoring tool 
