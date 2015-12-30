;; ~/.emacs.d/JCgit.el -*- mode: lisp-*-

;; La ligne suivante corrige un bug de déclaration
(setq magit-log-edit-confirm-cancellation t)

(setq magit-last-seen-setup-instructions "1.4.0")
(require 'magit)

;; (require 'magithub)
;; (require 'magit-gh-pulls) pb de dépendances avec  eieio-1.3, à réinstaller plus tard

;; n'affiche pas les commits en avance par rapport à upstream
(setq magit-status-sections-hook (delete 'magit-insert-unpushed-to-upstream magit-status-sections-hook))
