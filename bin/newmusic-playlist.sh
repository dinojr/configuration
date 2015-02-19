#!/bin/sh

cd /srv/multimedia/musique/ && find . -type f -mtime -20  | egrep '\.mp3$|\.flac$|\.ogg$' | awk '{ sub(/^\.\//, ""); print }' > /srv/multimedia/playlists/newmusic.m3u
