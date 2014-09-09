;; ~/.emacs.d/JCbbdb.el -*- mode: lisp-*-


;; file where things will be saved
;; (setq bbdb-file "~/.emacs.d/bbdb")

(require 'bbdb)

(add-to-list 'load-path "/home/wilk/.emacs.d/bbdb-vcard")




(bbdb-initialize 'gnus 'message)
(bbdb-mua-auto-update-init 'gnus 'message)

(add-hook 'mail-setup-hook 'bbdb-mail-aliases)
(add-hook 'message-setup-hook 'bbdb-mail-aliases)

(setq bbdb-mua-update-interactive-p '(query . create))

;; Raccourcis
