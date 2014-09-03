;; ~/.emacs.d/JClatex.el

(add-to-list 'load-path "~/info/emacs/auctex")
(setq TeX-data-directory "~/info/emacs/auctex/")
(add-to-list 'load-path "~/info/emacs/auctex/")
(add-to-list 'load-path "~/info/emacs/auctex/preview/")

(setq TeX-clean-confirm nil)
(setq TeX-auto-save t)
(setq TeX-parse-self t)
(setq-default TeX-master nil)
(add-hook 'LaTeX-mode-hook
  (function
    (lambda ()
      (add-hook 'kill-buffer-hook 'TeX-clean nil t)
      ;gestion de la table matière et autre...
      (reftex-mode 1)
      ;; Corrrection à la volée syntaxique
      (flyspell-mode 1)
      ;; dictionnaire évitant les erreurs d'accents
      (ispell-change-dictionary "francais")
      (TeX-fold-mode 1)
      (TeX-PDF-mode)
      ;; crochets automatiques pour exposants et indices
      (setq TeX-electric-sub-and-superscript t)
)))

(setq LaTeX-section-hook
      '(LaTeX-section-title
	LaTeX-section-section
	LaTeX-section-label))

(setq TeX-view-format "pdf")

;;rubber comme compilateur
(add-hook 'LaTeX-mode-hook (lambda()
  (setq TeX-command-default "rubber")
  (add-to-list 'LaTeX-indent-environment-list '("code") )
  (add-to-list 'LaTeX-indent-environment-list '("tikzpicture"))
  (add-to-list 'LaTeX-indent-environment-list '("pspicture"))
  (add-to-list 'LaTeX-indent-environment-list '("equation*"))
  (add-to-list 'LaTeX-indent-environment-list '("equation") )
  (add-to-list 'LaTeX-indent-environment-list '("align") )
  (add-to-list 'LaTeX-indent-environment-list '("align*") )
  (add-to-list 'LaTeX-indent-environment-list '("table") )
  (add-to-list 'LaTeX-indent-environment-list '("tabular") )
  (add-to-list 'LaTeX-indent-environment-list '("pspicture") )
  (add-to-list 'LaTeX-indent-environment-list '("tikzpicture") )
  (add-to-list 'LaTeX-indent-environment-list '("axis") )
  (add-to-list 'LaTeX-indent-environment-list '("psgraph") )
  (add-to-list 'LaTeX-indent-environment-list '("maple") )
  (add-to-list 'LaTeX-indent-environment-list '("figure") )
  (add-to-list 'LaTeX-indent-environment-list '("scope") )
))

(eval-after-load "latex"
  '(progn
    (add-to-list 'TeX-view-program-list
			  '("jcEvince" ("evince" " %o")))
    (add-to-list 'TeX-view-program-selection
		 '(output-pdf "jcEvince"))
    (customize-set-variable 'LaTeX-math-abbrev-prefix (kbd "ù"))
    ;; (require 'autopair-latex)
    (add-hook 'org-mode-hook 'LaTeX-math-mode)
    (setq TeX-insert-braces nil)
    ))

(defun jc-revert-and-rubber ()
  (interactive)
  (revert-buffer nil 1)
  (TeX-command "rubber" 'TeX-master-file 0)
  )

;; LaTeX end ;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;--------------------
;; RefTex
;;--------------------

(setq reftex-auto-recenter-toc t)
(setq reftex-toc-follow-mode nil)
(setq reftex-toc-include-labels t)
(setq reftex-toc-split-windows-fraction 0.3)
;; (setq reftex-label-regexps '("\\\\label{\\(?1:[^}]*\\)}" "\\[[^]]*\\<\\(meta\\)?label[[:space:]]*=[[:space:]]*{?\\(?1:[^],}]+\\)}?"))
;; (setq reftex-label-regexps '("\\\\label{\\(?1:[^}]*\\)}"
;; "\\[[^]]*\\<label[[:space:]]*=[[:space:]]*{?\\(?1:[^],}]+\\)}?"))

;; Pour utiliser d'autres mots-clefs que label
(eval-after-load 'reftex
  '(progn (add-to-list 'reftex-label-regexps
		 "\\[[^]]*\\<metalabel[[:space:]]*=[[:space:]]*{?\\(?1:[^],}]+\\)}?")
	 (reftex-compile-variables))
  )

;; Permet d'ignorer les occurences de label dans le code tikz
 (eval-after-load 'reftex
  '(progn (setq reftex-label-ignored-macros-and-environments '("tikzpicture" "pspicture" "pgfonlayer" "axis" "scope")))
  )

;; Je m'occupe de nommer mes labels
(eval-after-load 'reftex
  '(progn (setq reftex-insert-label-flags '("sft" t)))
  )

;;--------------------
;; RefTex end
;;--------------------

;;--------------------
;; AucTeX
;;--------------------

;; avec elpa
(require 'tex)

(setq TeX-fold-env-spec-list '(("[comment]" ("comment"))
			       ("[tikzpicture]" ("tikzpicture"))
			       ("[exercice]" ("exercice"))
			       ("[correction]" ("correction"))
			       ("[exoGuide]" ("exoGuide"))
			       ("[exoApp]" ("exoApp"))))

(eval-after-load "tex-fold" '(add-hook 'find-file-hook 'TeX-fold-buffer t))

(add-hook 'LaTeX-mode-hook 'LaTeX-math-mode)

(add-hook 'LaTeX-mode-hook
     	  (lambda () (set (make-variable-buffer-local 'TeX-electric-math)
     			  (cons "\\(" "\\)"))))

;; Raccourcis
(define-key key-translation-map (kbd "²") (kbd "\\"))
(add-hook 'LaTeX-mode-hook
	  (lambda () ;;(define-key LaTeX-mode-map (kbd  "<C-tab>")
	    ;;'indent-relative)
	    ;; (define-key LaTeX-mode-map (kbd  "<C-tab>") 'insert-tab)
	    (define-key LaTeX-mode-map (kbd  "<C-tab>") 'jc-indent-and-insert-tab)
	    (define-key LaTeX-mode-map (kbd  "<C-return>") 'jc-newline-and-indent)
	    (define-key LaTeX-mode-map (kbd  "<M-f7>") 'jc-revert-and-rubber)
	    ))
