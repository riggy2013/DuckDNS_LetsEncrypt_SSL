#!/bin/bash

token=<DUCKDNS_TOKEN>

echo url="https://www.duckdns.org/update?domains=$CERTBOT_DOMAIN&token=$token&txt=$CERTBOT_VALIDATION&verbose=true&clear=true" | curl -k -o duck.log -K -
