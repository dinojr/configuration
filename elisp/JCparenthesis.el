;; ~/.emacs.d/JCparenthesis.el -*- mode: lisp-*-

(show-paren-mode)

;; Rainbow-delimiters
(require 'rainbow-delimiters)
(add-hook 'LaTeX-mode-hook 'rainbow-delimiters-mode)
(add-hook 'emacs-lisp-mode-hook 'rainbow-delimiters-mode)
(add-hook 'lisp-mode-hook 'rainbow-delimiters-mode)

;; (require 'smartparens)
;; ;; do not autoinsert ' pair if the point is preceeded by word.  This
;; ;; will handle the situation when ' is used as a contraction symbol in
;; ;; natural language.  Nil for second argument means to keep the
;; ;; original definition of closing pair.
;; (sp-pair "'" nil :actions nil)

;; ;; emacs is lisp hacking enviroment, so we set up some most common
;; ;; lisp modes too
;; (sp-with-modes sp--lisp-modes
;;   ;; disable ', it's the quote character!
;;   (sp-local-pair "'" nil :actions nil)
;;   ;; also only use the pseudo-quote inside strings where it serve as
;;   ;; hyperlink.
;;   (sp-local-pair "`" "'" :when '(sp-in-string-p)))

;; ;; NOTE: Normally, `sp-local-pair' accepts list of modes (or a single
;; ;; mode) as a first argument.  The macro `sp-with-modes' adds this
;; ;; automatically.  If you want to call sp-local-pair outside this
;; ;; macro, you MUST supply the major mode argument.


;; ;; À voir à l'usage
;; (setq sp-autoinsert-if-followed-by-same 0)
;; (require 'smartparens)
(require 'smartparens-config)


(sp-with-modes '(
                 tex-mode
                 plain-tex-mode
                 latex-mode
		 org-mode
                 )
  ;; math modes, yay.  The :actions are provided automatically if
  ;; these pairs do not have global definition.
  ;; (sp-local-pair "$" "$")
  ;; (sp-local-pair "\\[" "\\]")
  ;; (sp-local-pair "\\left(" "\\right)")
  ;; (sp-local-pair "\\left{" "\\right}")
  ;; (sp-local-pair "\\left[" "\\right]")
  ;; (sp-local-pair "\\]" "\\[")
  ;; (sp-local-tag "\\b" "\\begin{_}" "\\end{_}")
  ;; (sp-local-tag "$" "\\(" "\\)") ;; ne marche pas
  )

;; Vérifier que latex-mode est bien dans sp-navigate-consider-stringlike-sexp

(sp-use-paredit-bindings)
(smartparens-global-mode)
