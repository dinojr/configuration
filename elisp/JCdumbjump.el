;; ~/.emacs.d/JCdumpjump.el -*- mode: emacs-lisp-*-
(require 'dumb-jump)
(add-hook 'xref-backend-functions #'dumb-jump-xref-activate)
