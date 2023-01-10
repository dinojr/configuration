;; ~/.emacs.d/JCavy.el -*- mode: emacs-lisp-*-
(use-package avy)
(avy-setup-default)
(global-set-key (kbd "C-: j") 'avy-goto-char)
(global-set-key (kbd "C-: k") 'avy-goto-char-2)
(global-set-key (kbd "C-: u") 'avy-goto-word-1)
(global-set-key (kbd "C-: i") 'avy-goto-line)
