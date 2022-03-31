#!/bin/bash

GRILLE_PDF="/home/wilk/enseignement/TP/grille-evaluation.pdf"
FICHIER=$1
FICHIER_GRILLE=${FICHIER/.pdf/-grille.pdf}
echo "fichier $FICHIER"
pdftk $GRILLE_PDF $FICHIER cat output $FICHIER_GRILLE
rm $FICHIER

