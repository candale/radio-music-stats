#!/bin/bash
set -e

for sample in /app/*.mp3; do
    echo "Using sample $sample"

    radio=$(echo $sample | cut -d '-' -f 1)
    song=$(songrec audio-file-to-recognized-song $sample | jq '. | "\(.track.title) - \(.track.subtitle)"')
    if [ -z "$song" ] || grep -q 'null' <<<"$song"; then
        echo "No matches for sample [$sample]. Skipping"
	rm "$sample"
        continue
    fi
    echo "Got song [$song] from sample [$sample]"
    
    songs_file_name="$radio-songs.csv"
    if [ ! -f "$songs_file_name" ]; then
	echo "Creating songs file $songs_file_name"
        touch "$songs_file_name";
    fi

    last_song=$(tail -n 1 "$songs_file_name" | cut -d ';' -f 2)
    if [ "$last_song" != "$song" ]; then
        echo "$(date +'%Y.%m.%d %H:%M:%S');$song" >> "$songs_file_name"
    fi

    rm $sample
done
