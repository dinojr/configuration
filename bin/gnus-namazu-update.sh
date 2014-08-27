#!/bin/bash
emacs -batch -l ~/.emacs.d/emacs_noninteractive.el -l ~/.gnus.el -f gnus-namazu-update-all-indices
