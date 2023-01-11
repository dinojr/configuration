#!/bin/bash

PDF_SUFFIX="corr.pdf"
DIR="corr"
XOPP_SUFFIX=".xopp"
ACORRIGER="Reste à corriger: "
[ ! -d $DIR ] && mkdir $DIR
TOTAL=0

for i in $(fdfind -t f -d 1 .*\(.pdf\|.PDF\) ./ )
do
    FILENAME=$i
    FILENAME_BASE="${i/.pdf/}"
    echo $FILENAME_BASE
    FILENAME_BASE="${FILENAME_BASE/.PDF/}"
    echo $FILENAME_BASE
    XOPP_FILENAME="$FILENAME_BASE$XOPP_SUFFIX"
    echo $XOPP_FILENAME
    if [ -f $XOPP_FILENAME ]
    then PDF_FILENAME="$DIR/$FILENAME_BASE-$PDF_SUFFIX"
	 if [ ! -f "$PDF_FILENAME" ]
	 then echo "On pdfise la copie de $FILENAME_BASE"
	      xournalpp -p "$PDF_FILENAME" "$XOPP_FILENAME"
	 else echo "$FILENAME_BASE déjà fait"
	 fi
    else echo -e "fichier \e[31m$FILENAME\e[0m à corriger"
	 ACORRIGER+="\n\e[31m$FILENAME\e[0m"
	 ((TOTAL+=1))
    fi
done
echo -e "$ACORRIGER"
echo "total: $TOTAL"
