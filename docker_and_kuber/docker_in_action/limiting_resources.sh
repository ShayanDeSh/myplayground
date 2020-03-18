#!/bin/bash

docker container run -d --name ch6_mariadb \
    --memory 256m \
    --cpu-shares 1024 \
    --cap-drop net_raw \
    -e MYSQL_ROOT_PASSWORD=test \
    mariadb:5.5

docker stats ch6_mariadb

docker container run -d -P --name ch6_wordpress --memory 512m \
    --cpu-shares 512 \
#   --cpus 0.75 \
    --cap-drop net_raw \
    --link ch6_mariadb:mysql \
    -e WORDPRESS_DB_PASSWORD=test \
    wordpress:5.0.0-php7.2-apache


docker container run -d \
    --cpuset-cpus 0 \
    --name ch6_stresser dockerinaction/ch6_stresser

docker container run -it --rm dockerinaction/ch6_htop
