;; ~/.emacs.d/JCavy.el -*- mode: lisp-*-
(require 'avy)
(avy-setup-default)
(global-set-key (kbd "C-c j") 'avy-goto-char)
(global-set-key (kbd "C-c k") 'avy-goto-char-2)
(global-set-key (kbd "C-c u") 'avy-goto-word-1)
(global-set-key (kbd "C-c i") 'avy-goto-line)

(require 'ace-isearch)
(global-ace-isearch-mode 1)

(custom-set-variables
 '(ace-isearch-input-length 5)
 '(ace-isearch-jump-delay 0.25)
 '(ace-isearch-function 'avy-goto-word-1)
 '(ace-isearch-use-jump 'printing-char))
 
(define-key isearch-mode-map (kbd "C-'") 'ace-isearch-jump-during-isearch)
