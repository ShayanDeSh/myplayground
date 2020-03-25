#!/bin/bash
trap "exit" SIGINT
mkdir /var/htdocs
while :
do
    echo $(date) this is your fortune
    /usr/games/fortune > /var/htdocs/index.html
    sleep 10
done
