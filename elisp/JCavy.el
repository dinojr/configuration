;; ~/.emacs.d/JCavy.el -*- mode: lisp-*-
(require 'avy)
(avy-setup-default)
(global-set-key (kbd "C-c j") 'avy-goto-char)
(global-set-key (kbd "C-c k") 'avy-goto-char-2)
(global-set-key (kbd "C-c u") 'avy-goto-word-1)
(global-set-key (kbd "C-c i") 'avy-goto-line)


