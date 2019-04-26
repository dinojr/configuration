#!/bin/bash
emacsclient -nw -c -F '((minibuffer . only)(name . "Packages")(height . 2))' -e '(jc-ask-package-management)'
