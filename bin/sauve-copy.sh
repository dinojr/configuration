#!/bin/bash

DATE=`date +%A-%d-%m-%y-%T`
PASSWORD="eigen4copies"
DIR="$HOME/enseignement/2017-2018/notes/cc-backups"
FILE=$DIR/cc-$DATE.sql
mysqldump --enable-cleartext-plugin --user=root -p$PASSWORD cc > $FILE
