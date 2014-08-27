#!/bin/bash
if [[ $(pgrep -f emacs) && $(ping -c 1 -W 2 imap.free.fr) ]]
#then echo emacs -batch -l ~/.emacs -l ~/.gnus.el -f gnus-agent-batch >/dev/null 2>&1
then /home/wilk/bin/gnus-agent-fetch.sh  #>/dev/null 2>&1
     /home/wilk/bin/gnus-namazu-update.sh #>/dev/null 2&>1
fi


