#!/bin/bash

# creating docker volume
docker volume create \
    --driver local \
    --label example=location \
    location-example

# inspecting the volume
docker volume inspect \
    location-example \
    --format "{{json .Mountpoint}}"

