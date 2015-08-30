#!/bin/bash
find . -name "* *.jpg" |
while read p
do
  f=${p##*/}
  d=${p%/*}
  mv "$d/$f" "$d/${f// /_}"
done
