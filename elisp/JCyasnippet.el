;; ~/emacs.d/JCyasnippet.el -*- mode: emacs-lisp-*-


;; (use-package yasnippet-snippets)

(use-package yasnippet
  ;; :ensure yasnippet-snippets
  :custom
  (yas-verbosity 2)
  (yas-wrap-around-region t)
  (yas-global-mode 1)
  (yas-triggers-in-field t); Enable nested triggering of snippets
  (yas-indent-line nil)
  ;; (yas-snippet-dirs '("~/.emacs.d/snippets" "~/.emacs.d/elpa/yasnippet-snippets-20220713.1234/"))
  
  :config
  ;; afterwards
  ;; (add-to-list 'yas-snippet-dirs "~/.emacs.d/snippets")
  (yas-reload-all)
  (yas-global-mode)
  (add-to-list 'sp-no-reindent-after-kill-modes 'latex-mode)
  ;; as long as yasnippet-snippets doens't install through package-install
  (progn (let ((snippets-dir "~/.emacs.d/elpa/yasnippet-snippets-20220713.1234/")
	       (snippets-package-file "~/.emacs.d/elpa/yasnippet-snippets-20220713.1234/yasnippet-snippets.el"))
	   (add-to-list 'yas-snippet-dirs snippets-dir)
	   (load-file snippets-package-file))))

