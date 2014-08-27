#!/bin/bash
# NAME=${1%.py}
# NAMEPYG="$NAME.pyg"
FILE=$1
echo $FILE
OUTFILE=$FILE.out.pyg
echo $OUTFILE
pygmentize -l python -f latex -F tokenmerge  -P verboptions=fontsize=\\footnotesize -o $OUTFILE $FILE
