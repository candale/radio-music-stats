# radio-music-stats
How many times does a radio station play the same song? This repo is for answering that question.

## Quick start

Build the images:
```shell
# build the image that takes samples
docker build -f Dockerfile.sampler -t radio-sampler

# build the image that recognizes the songs
docker build -f Dockerfile.reko -t radio-reko .

# Add stations to stations.txt. There are already some in the file. The script only works radios
# that expose a stream in .aacp format. Make sure there is no blank line at the end :grin:
echo "rock https://live.rockfm.ro/rockfm.aacp" >> stations.txt

# Start the sampler in the root of the project
docker run -ti --rm -v $(pwd):/app radio-sampler

# Start the recognizer in the root of the project
docker run -ti --rm -v $(pwd):/app radio-reko
```

You'll start seeing some .mp3 files coming and going and then a file for each station,
"<station-name>-songs.csv" that contains the recognized songs and a timestamp.
