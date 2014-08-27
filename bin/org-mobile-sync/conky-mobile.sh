#!/bin/bash                                                                     
ORGFILE="/home/wilk/org/from-mobile.org" # replace that path according to your needs.
KILLNR="$(ps ax | grep "conky -c conkyrc" | grep -v grep | sed 's/ pts.*//g')"
NEWTASK="$(cat $ORGFILE | grep -v ^$ | grep -v 20[0-9][0-9])"

if [ -n "$NEWTASK" ];
then
    if [ -n "$KILLNR" ];
    then
        exit
    else
        conky -c ~/.Conky/conkyrc &
    fi
else
    if [ -n "$KILLNR" ];
    then
        kill $KILLNR
    else
        exit
    fi
fi
