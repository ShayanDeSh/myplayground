#!/bin/sh
printf "Live mailer has started.\n"
while true
do
    MESSAGE=$(nc -l -p 33333)
    aws ses send-email --from $1 \
        --destination {\"ToAddresses\":[\"$2\"]} \
        --message "{\"Subject\":{\"Date\":\"Mailer Alert\"},\
                    \"Body\":{\"Text\":{\"Data\":\"${MESSAGE}\"}}}"
    sleep 1
done
