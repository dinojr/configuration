#!/bin/bash
DIR=/home/wilk/beets-admin/
#export PYTHONPATH=$PYTHONPATH:/usr/local/lib/python3.6/dist-packages/
FILE=beets-lossless.txt
date > $DIR/$FILE
beet list -a albumformat:FLAC -f '$albumartist - $album - $albumformat' >> $DIR/$FILE
