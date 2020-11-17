#/bin/bash
PDF=$1
NOM=${PDF/.pdf/-split.pdf}
SPLIT="split.pdf"
ONE="1.pdf"
TWO="2.pdf"
THREE="3.pdf"
FOUR="4.pdf"
FOURTHREE="43.pdf"
TWOONE="21.pdf"
mutool poster -x2  $PDF $SPLIT
# order is 2 3 4 1
pdftk A=$SPLIT cat Aodd output $TWOFOUR
pdftk A=$SPLIT cat Aeven output $THREEONE
pdftk A=$TWOFOUR cat Aeven output $THREE
pdftk A=$TWOFOUR cat Aodd output $FOUR
pdftk A=$THREEONE cat Aodd output $TWO
pdftk A=$THREEONE
cat Aeven output $ONE

pdftk A=$ONE B=$TWO C=$THREE D=$FOUR shuffle A B C D output $NOM

