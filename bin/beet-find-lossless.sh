#!/bin/bash
DIR=/srv/multimedia/musique/ADMINISTRATION/
FILE=beets-lossless.txt
date > $DIR/$FILE
beet list "format:flac" -f '$albumartist - $album - $format' |uniq >> $DIR/$FILE

