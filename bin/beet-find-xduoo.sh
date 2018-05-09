#!/bin/bash
DIR=/srv/multimedia/musique/ADMINISTRATION/
#export PYTHONPATH=$PYTHONPATH:/usr/local/lib/python3.6/dist-packages/
FILE=beets-xduoo.txt
date > $DIR/$FILE
beet list -a albumformat:FLAC -f '$albumartist - $album - $albumformat' >> $DIR/$FILE
