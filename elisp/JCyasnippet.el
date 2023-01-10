;; ~/emacs.d/JCyasnippet.el -*- mode: emacs-lisp-*-

(use-package yasnippet) ;; not yasnippet-bundle
(yas-global-mode 1)
(setq yas-triggers-in-field t); Enable nested triggering of snippets
(setq yas-indent-line nil)
(add-to-list 'sp-no-reindent-after-kill-modes 'latex-mode)
;; Raccourcis
				
