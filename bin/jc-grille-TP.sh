#!/bin/bash

GRILLE_PDF="/home/wilk/enseignement/TP/grille-evaluation.pdf"
GRILLE_SUFFIX="grille.pdf"
DIR="grille"
[ ! -d $DIR ] && mkdir $DIR

for i in *.pdf
do
    FILENAME=$i
    FILENAME_BASE="${i/.pdf/}"
    FICHIER_GRILLE="$DIR/$FILENAME_BASE-$GRILLE_SUFFIX"
    if [ ! -f "$FICHIER_GRILLE" ]
    then echo "On grille la copie de $FILENAME_BASE"
	 pdftk $GRILLE_PDF $FILENAME cat output $FICHIER_GRILLE
	 rm $FILENAME
    else echo "$FILENAME_BASE déjà fait"
    fi
done


