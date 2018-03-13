#!/bin/bash
DIR=/srv/multimedia/musique/ADMINISTRATION/
FILE=beets-lossy.txt
date > $DIR/$FILE
beet list "format::(OGG|MP3)" -f '$albumartist - $album - $format' |uniq >> $DIR/$FILE

