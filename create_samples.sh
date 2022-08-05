#!/bin/bash
set -x

while true; do
    cat stations.txt | while read station_info; do
        name=$(echo $station_info | cut -d ' ' -f 1)
        url=$(echo $station_info | cut -d ' ' -f 2)
	echo "=== Creating sample for [$name] with url [$url]"
        < /dev/null ffmpeg -y -t "00:00:5" -i $url -codec:a libmp3lame "$name-$(tr -dc A-Za-z0-9 </dev/urandom | head -c 4 ; echo '').mp3"
    done
    sleep 30
done
