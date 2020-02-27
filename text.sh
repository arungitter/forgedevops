#!/bin/sh

response=$(curl --write-out %{http_code} --silent --connect-timeout 30 --output /dev/null http://www.google.com)

echo "$response"
