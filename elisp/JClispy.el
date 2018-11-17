;; ~/.emacs.d/JClispy.el -*- mode: lisp-*-

(require 'lispy)

(add-hook 'emacs-lisp-mode-hook (lambda () (lispy-mode 1)))
(add-hook 'LaTeX-mode-hook (lambda () (lispy-mode 1)))
