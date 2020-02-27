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
    --cap-drop net_raw \
    --link ch6_mariadb:mysql \
    -e WORDPRESS_DB_PASSWORD=test \
    wordpress:5.0.0-php7.2-apache
