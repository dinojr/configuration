#!/bin/bash

GRILLE_PDF="/home/wilk/enseignement/TP/grille-evaluation.pdf"
DIR="orig"
[ ! -d $DIR ] && mkdir $DIR

for i in "$(find -path "./orig/*.pdf")"
do
    FILENAME="$i"
    BASEFILENAME="$(basename $FILENAME)"
    echo "$FILENAME"
    # echo $BASEFILENAME
    # FILENAME_BASE="${i/.pdf/}"
    # FICHIER_GRILLE="$DIR/$FILENAME_BASE-$GRILLE_SUFFIX"
    if [ ! -f "$BASEFILENAME" ]
    then echo "On grille la copie de $FILENAME_BASE"
	 pdftk "$GRILLE_PDF" "$FILENAME" cat output "$BASEFILENAME"
    else echo "$FILENAME_BASE déjà fait"
    fi
done


