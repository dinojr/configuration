;; ~/.emacs.d/JCConTeXt.el -*- mode: emacs-lisp-*-

(setq ConTeXt-Mark-version "IV")
(add-hook 'LaTeX-mode-hook #'latex-extra-mode)

(add-hook 'LaTeX-mode-hook
  (function
    (lambda ()
      (add-hook 'kill-buffer-hook 'TeX-clean nil t)
      ;gestion de la table matière et autre...
      (reftex-mode 1)
      ; synctex pour la synchro entre pdf et tex
      (TeX-source-correlate-mode 1)
      ; PDFmode
      (TeX-PDF-mode)
      ;; Corrrection à la volée syntaxique
      (flyspell-mode 1)
      ;; dictionnaire évitant les erreurs d'accents
      (ispell-change-dictionary "francais")
      (TeX-fold-mode 1)
      ;; crochets automatiques pour exposants et indices
      (setq TeX-electric-sub-and-superscript t)
      ;; (setq TeX-electric-math '("$" . "$"))
      (setq TeX-electric-math nil)
      ;;
      (electric-indent-local-mode nil)
      ;; pour que smartparens puisse jouer son rôle
      (define-key LaTeX-mode-map (kbd "$") 'self-insert-command)
)))

(with-eval-after-load 'context
  (customize-set-variable 'LaTeX-math-abbrev-prefix (kbd "ù"))
  ;; (require 'autopair-latex)
  (setq TeX-insert-braces nil)
  (setq LaTeX-fill-break-at-separators '(\\\( \\\[))
  )

(add-hook 'ConTeXt-mode-hook 'LaTeX-math-mode)

(define-key key-translation-map (kbd "²") (kbd "\\"))
(add-hook 'LaTeX-mode-hook
	  (lambda () ;;(define-key LaTeX-mode-map (kbd  "<C-tab>")
	    ;;'indent-relative)
	    ;; (define-key LaTeX-mode-map (kbd  "<C-tab>") 'insert-tab)
	    (define-key LaTeX-mode-map (kbd  "<C-tab>") 'indent-relative)
	    (define-key LaTeX-mode-map (kbd  "<C-return>") 'jc-newline-and-indent)
	    (define-key LaTeX-mode-map (kbd  "<M-f7>") 'jc-revert-and-rubber)
	    ))
