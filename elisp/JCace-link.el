;; ~/.emacs.d/JCacelink.el -*- mode: emacs-lisp-*-
(use-package ace-link)
(ace-link-setup-default)

(define-key org-mode-map (kbd "M-o") 'ace-link-org)

(define-key gnus-summary-mode-map (kbd "M-o") 'ace-link-gnus)
(define-key gnus-article-mode-map (kbd "M-o") 'ace-link-gnus)
