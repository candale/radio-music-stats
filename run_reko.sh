#!/bin/bash

while true; do
    find -name \*.mp3 | entr -d /app/process_samples.sh
    sleep 30
done
