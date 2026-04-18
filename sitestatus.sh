#!/bin/bash

#This script returns a website status code
#The site you want to know the status is set as a parameter
#If you want to know the status of "http://github.com", you type "./sitestatus.sh http://github.com"

if [ -z "$1" ]; then
    echo "Usage: $0 <url>"
    exit 1
fi

site_status=$(curl --write-out "%{http_code}\n" --silent --output /dev/null "$1")

echo "$1: $site_status"