#!/bin/bash

creating docker volume for cassandra
docker volume create \
    --driver local \
    --label example=cassandra \
    cass-shared

# creating a cassandra container
docker run -d \
    --volume cass-shared:/var/lib/cassandra/data \
    --name cass1 \
    cassandra:2.2

sleep 2

# create a cassandra container and run cqlsh and connect it to cass1
docker run -it --rm \
    --link cass1:cass \
    cassandra:2.2 cqlsh cass

# create a keyspace
create keyspace docker_hello_world
with replication = {
    'class' : 'SimpleStrategy',
    'replication_factor': 1
};

# check if added 
select *
from system.schema_keyspaces
where keyspace_name = 'docker_hello_world';
