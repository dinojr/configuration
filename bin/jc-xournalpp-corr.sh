#!/bin/bash

PDF_SUFFIX="corr.pdf"
DIR="corr"

[ ! -d $DIR ] && mkdir $DIR
for i in *.xopp
do
    FILENAME=$i
    FILENAME_BASE="${i/.xopp/}"
    PDF_FILENAME="$DIR/$FILENAME_BASE-$PDF_SUFFIX"
    if [ ! -f "$PDF_FILENAME" ]
    then echo "On pdfise la copie de $FILENAME_BASE"
	 xournalpp -p "$PDF_FILENAME" "$FILENAME"
    else echo "$FILENAME_BASE déjà fait"
    fi
done
