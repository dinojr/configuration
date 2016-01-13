#!/bin/sh
MUSICDIR="/srv/multimedia/musique/"
# fetch new art
# beet fetchart

# resize covers
# find "$MUSICDIR" -iname "cover.jpg" |
# find . -type f -iname 'cover.jpg' -exec bash -c '
find $MUSICDIR -type f -iname 'cover.*' -exec bash -c '
  for file do
    echo $file
    #EXTENSION="${file##*.}"
    EXTENSION="png"
    FILENAME="${file%.*}"
    NEW_MED_NAME="${FILENAME}_med.${EXTENSION}"
    NEW_SMALL_NAME="${FILENAME}_small.${EXTENSION}"
    if [ ! -f "${NEW_MED_NAME}" ]; then
        convert "${file}" -adaptive-resize 200x200 "${NEW_MED_NAME}"
    fi
    if [ ! -f "${NEW_SMALL_NAME}" ]; then
       convert "${file}" -adaptive-resize 100x100 "${NEW_SMALL_NAME}"
    fi
  done
' bash {} +
