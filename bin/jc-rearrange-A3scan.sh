#/bin/bash
#A3 scans should be in the ordre 2 3 4 1, gives an A4 document in the right order
PDF=$1
PDFSMALL=${PDF/.pdf/-small.pdf}
SPLIT="split.pdf"
ONE="1.pdf"
TWO="2.pdf"
THREE="3.pdf"
FOUR="4.pdf"
TWOFOUR="24.pdf"
THREEONE="31.pdf"
BIG="big.pdf"
mutool poster -x2  $PDF $SPLIT
# order is 2 3 4 1
pdftk A=$SPLIT cat Aodd output $TWOFOUR
pdftk A=$SPLIT cat Aeven output $THREEONE
pdftk A=$TWOFOUR cat Aeven output $FOUR
pdftk A=$TWOFOUR cat Aodd output $TWO
pdftk A=$THREEONE cat Aodd output $THREE
pdftk A=$THREEONE cat Aeven output $ONE

pdftk A=$ONE B=$TWO C=$THREE D=$FOUR shuffle A B C D output $BIG
gs -dNOPAUSE -dBATCH -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/ebook -sOutputFile=$PDFSMALL $BIG

for i in $SPLIT $TWOFOUR $THREEONE $FOUR $THREE $TWO $ONE $BIG
	do rm $i
done
