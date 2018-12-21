#!/bin/bash

NOM=$1
NOM_GIF=${NOM/.pdf/_%d.gif}
gm convert -density 150 +adjoin $NOM $NOM_GIF
