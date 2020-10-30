#!/bin/bash
DIR=/home/wilk/beets-files/
#export PYTHONPATH=$PYTHONPATH:/usr/local/lib/python3.6/dist-packages/
FILE=beets-to-buy.txt
date > $DIR/$FILE
beet list -a "albumformat::(MP3|OGG)" -f '$albumartist - $album - $albumformat' added- >> $DIR/$FILE

