#!/bin/bash
convert -resize 640x480 $1 ${1/.*/-640x480}.png

