#!/bin/bash
#emacs-snapshot -batch -l ~/.emacs -l ~/.gnus.el -f gnus-agent-batch >/dev/null 2>&1
# emacs-snapshot -batch -l ~/.emacs -l ~/.gnus.el -f gnus-agent-batch
emacs-snapshot -batch -l ~/.emacs.d/JC-gnus-agent.el -l ~/.gnus.el -f gnus-agent-batch 
emacs-snapshot -batch -l ~/.emacs.d/JC-gnus-agent.el -l ~/.gnus.el -f gnus-namazu-update-index


