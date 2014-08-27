#!/bin/bash

NOM=$1
NOM_CORRIGE=${NOM/.pdf/-corrige.pdf}

RANGE=$2

pdfjam --landscape -o $NOM_CORRIGE $NOM $RANGE