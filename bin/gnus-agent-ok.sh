#!/bin/bash
# if [[ $(pgrep -f emacs) && $(ping -c 1 -W 2 imap.free.fr) ]]
# then /home/wilk/bin/gnus-agent-fetch.sh  #>/dev/null 2>&1
#      /home/wilk/bin/gnus-namazu-update.sh #>/dev/null 2&>1
# fi

if [[ $(ping -c 1 -W 2 imap.free.fr) ]]
then /home/wilk/bin/gnus-agent-fetch.sh  #>/dev/null 2>&1
     /home/wilk/bin/gnus-namazu-update.sh #>/dev/null 2&>1
fi


