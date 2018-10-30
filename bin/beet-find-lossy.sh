#!/bin/bash
DIR=/home/wilk/configuration/beets
#export PYTHONPATH=$PYTHONPATH:/usr/local/lib/python3.6/dist-packages/
FILE=beets-lossy.txt
date > $DIR/$FILE
beet list -a "albumformat::(MP3|OGG)" -f '$albumartist - $album - $albumformat' >> $DIR/$FILE

