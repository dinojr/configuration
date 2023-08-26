;; ~/.emacs.d/JCmbsync.el -*- mode: emacs-lisp-*-

(require 'gnus)

;; f runs the command mbsync
(require 'mbsync)
(add-hook 'mbsync-exit-hook 'gnus-group-get-new-news)
(define-key gnus-group-mode-map (kbd "f") 'mbsync)

(gnus-demon-add-handler 'mbsync 5 .5)
