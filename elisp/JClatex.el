;; ~/.emacs.d/JClatex.el -*- mode: lisp-*-

;; (add-to-list 'load-path "~/info/emacs/auctex")
;; (setq TeX-data-directory "~/info/emacs/auctex/")
;; (add-to-list 'load-path "~/info/emacs/auctex/")
;; (add-to-list 'load-path "~/info/emacs/auctex/preview/")

(require 'tex)

(add-hook 'LaTeX-mode-hook #'latex-extra-mode)
(setq  latex/next-error-skip-confirmation t)

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
)))

(setq LaTeX-section-hook
      '(LaTeX-section-title
	LaTeX-section-section
	LaTeX-section-label))

;; (setq TeX-view-format "pdf")

(add-to-list 'TeX-command-list
	     '("rubber" "rubber --cache --inplace --maxerr -1 --short --force --warn all --pdf %t" TeX-run-command nil t :help "Run rubber with pdflatex directly")
	     )

(add-to-list 'TeX-command-list
	      '("rubberps" "rubber --cache --inplace --maxerr -1 --short --force --warn all --ps --pdf %t" TeX-run-command nil t :help "Run rubber with latex->dvips->ps2pdf")
	     )

(add-to-list 'TeX-command-list
	     '("pdflatex-vuibert" "pdflatex -fmt ../../../vuistand-fmt.fmt %t" TeX-run-command nil t :help "Run pdflatex with custom format file"))


;;rubber comme compilateur
(add-hook 'LaTeX-mode-hook (lambda()
  ;; (setq TeX-command-default "rubber")
  ;; (add-to-list 'LaTeX-indent-environment-list '("code") )
;;   (add-to-list 'LaTeX-indent-environment-list '("tikzpicture"))
;;   (add-to-list 'LaTeX-indent-environment-list '("pspicture"))
;;   (add-to-list 'LaTeX-indent-environment-list '("equation*"))
;;   (add-to-list 'LaTeX-indent-environment-list '("equation") )
;;   (add-to-list 'LaTeX-indent-environment-list '("align") )
;;   (add-to-list 'LaTeX-indent-environment-list '("align*") )
;;   (add-to-list 'LaTeX-indent-environment-list '("table") )
;;   (add-to-list 'LaTeX-indent-environment-list '("tabular") )
;;   (add-to-list 'LaTeX-indent-environment-list '("pspicture") )
;;   (add-to-list 'LaTeX-indent-environment-list '("tikzpicture") )
;;   (add-to-list 'LaTeX-indent-environment-list '("axis") )
;;   (add-to-list 'LaTeX-indent-environment-list '("psgraph") )
;;   (add-to-list 'LaTeX-indent-environment-list '("maple") )
;;   (add-to-list 'LaTeX-indent-environment-list '("figure") )
;;   (add-to-list 'LaTeX-indent-environment-list '("scope") )
  ;;
  ))
(setq LaTeX-clean-intermediate-suffixes
      (quote
       ("\\.aux" "\\.bbl" "\\.blg" "\\.brf" "\\.fot" "\\.glo" "\\.gls" "\\.idx" "\\.ilg" "\\.ind" "\\.lof" "\\.log" "\\.lot" "\\.out" "\\.toc" "\\.url" "\\.thm" "\\.ps" "\\.dvi" "\\.tex~" "\\.nav" "\\.snm" "\\-autopp.log")))

(setq LaTeX-indent-environment-list
      (quote
       (("verbatim" current-indentation)
	("verbatim*" current-indentation)
	("array" )
	("displaymath")
	("eqnarray")
	("eqnarray*")
	("equation")
	("equation*")
	("picture")
	("tabbing")
	("table")
	("table*")
	("tabular")
	("tabular*")
	("code")    
	("tikzpicture")
	("pspicture") 
	("align")   
	("align*")
	("table")    
	("tabular")
	("pspicture")
	("tikzpicture")
	("axis")
	("psgraph")
	("maple")
	("figure")
	("scope")
	)
       ))
      


(eval-after-load "latex"
  '(progn
    (setq TeX-view-program-selection
      '(((output-dvi style-pstricks) "dvips and gv")
         (output-dvi "xdvi")
         (output-pdf "PDF Tools")
         (output-html-open "xdg-open")))
    (customize-set-variable 'LaTeX-math-abbrev-prefix (kbd "ù"))
    ;; (require 'autopair-latex)
    (add-hook 'org-mode-hook 'LaTeX-math-mode)
    (setq TeX-insert-braces nil)
    (setq LaTeX-fill-break-at-separators '(\\\( \\\[))
    ))



(defun jc-revert-and-rubber ()
  (interactive)
  (revert-buffer nil 1)
  (TeX-command "rubber" 'TeX-master-file 0)
  )

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

;; (eval-after-load 'latex '(add-hook 'TeX-after-compilation-finished-functions 'TeX-revert-document-buffer))

(eval-after-load 'latex '(add-hook 'TeX-after-TeX-LaTeX-command-finished-hook 'TeX-revert-document-buffer))


(require 'notifications)
(defun jc-notify-TeX-run-finish (file)
  "Display a notification when a TeX run is finished."
  (notifications-notify :title "AUCTeX"
                        :body (format "Finished: %s\n%s" (file-name-nondirectory file) (current-message))))
;; (add-hook 'TeX-after-compilation-finished-functions #'jc-notify-TeX-run-finish)
(add-hook 'TeX-after-TeX-LaTeX-command-finished-hook #'jc-notify-TeX-run-finish)


(add-to-list 'auto-mode-alist '( "\\.tikz\\'" . tex-mode))
(setq TeX-fold-env-spec-list '(("[comment]" ("comment"))
			       ("[tikzpicture]" ("tikzpicture"))
			       ("[exercice]" ("exercice"))
			       ("[correction]" ("correction"))
			       ("[exoGuide]" ("exoGuide"))
			       ("[exoApp]" ("exoApp"))))

(eval-after-load "tex-fold" '(add-hook 'find-file-hook 'TeX-fold-buffer t))

(add-hook 'LaTeX-mode-hook 'LaTeX-math-mode)

;; (add-hook 'LaTeX-mode-hook
;;      	  (lambda () (set (make-variable-buffer-local 'TeX-electric-math)
;;      			  (cons "\\(" "\\)"))))
;; (add-hook 'LaTeX-mode-hook 'TeX-global-PDF-mode)

;; Raccourcis
(define-key key-translation-map (kbd "²") (kbd "\\"))
(add-hook 'LaTeX-mode-hook
	  (lambda () ;;(define-key LaTeX-mode-map (kbd  "<C-tab>")
	    ;;'indent-relative)
	    ;; (define-key LaTeX-mode-map (kbd  "<C-tab>") 'insert-tab)
	    (define-key LaTeX-mode-map (kbd  "<C-tab>") 'indent-relative)
	    (define-key LaTeX-mode-map (kbd  "<C-return>") 'jc-newline-and-indent)
	    (define-key LaTeX-mode-map (kbd  "<M-f7>") 'jc-revert-and-rubber)
	    ))
