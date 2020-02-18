#!/bin/sh

if [ "$1" = "-i" ]; then
    CLIENT_ID=$2
fi

if [ ! -n "$CLIENT_ID" ]; then
    echo "Client ID not set"
    exit 1
fi

DB_CID=$(docker run -d -e MYSQL_ROOT_PASSWORD=ch2demo mysql:5.7)
docker start $DB_CID

MAILER_CID=$(docker run -d dockerinaction/ch2_mailer)
docker start $MAILER_CID

WP_CID=$(docker create \
    --link $DB_CID:mysql -p 80 \
    --read-only -v /run/apache2 --tmpfs /tmp \
    -e WORDPRESS_DB_NAME=$CLIENT_ID \
    -e WORDPRESS_DB_PASSWORD=ch2demo \
    --read-only wordpress:5.0.0-php7.2-apache)
docker start $WP_CID

AGENT_CID=$(docker create \
    --name agent_$CLIENT_ID \
    --link $WP_CID:insideweb \
    --link $MAILER_CID:insidemailer \
    dockerinaction/ch2_agent)
docker start $AGENT_CID
