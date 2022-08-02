;; ~/.emacs.d/JCavy.el -*- mode: emacs-lisp-*-
(require 'avy)
(avy-setup-default)
(global-set-key (kbd "C-c j") 'avy-goto-char)
(global-set-key (kbd "C-c k") 'avy-goto-char-2)
(global-set-key (kbd "C-c u") 'avy-goto-word-1)
(global-set-key (kbd "C-c i") 'avy-goto-line)

(require 'ace-jump-helm-line)
(eval-after-load "helm"
  '(define-key helm-map (kbd "ù") 'ace-jump-helm-line))


(setq ace-jump-helm-line-style 'post)
(setq ace-jump-helm-line-background t)
(setq ace-jump-helm-line-default-action nil)
(ace-jump-helm-line-autoshow-mode)
