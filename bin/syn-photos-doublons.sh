#!/bin/bash
IFS=$'\n'
for i in $(find -iname '*_1.jpg' -print -o -name "@eaDir" -prune);
do [ ! -f "${i/_1.jpg/.jpg}" ] && ls "$i";
done
