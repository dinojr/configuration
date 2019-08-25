;; ~/.emacs.d/JCspellcheck.el -*- mode: emacs-lisp-*-

(setq flyspell-use-meta-tab nil)
(setq ispell-program-name "aspell")
(setq ispell-list-command "list")

(add-hook 'text-mode-hook
	  (lambda () (ispell-change-dictionary "francais"))
	  )
(setq ispell-tex-skip-alists
      (list
       (append (car ispell-tex-skip-alists)
               '(("\\\\cite"            ispell-tex-arg-end)
                 ("\\\\nocite"          ispell-tex-arg-end)
                 ("\\\\includegraphics" ispell-tex-arg-end)
                 ("\\\\figScale"         ispell-tex-arg-end)
                 ("\\\\author"          ispell-tex-arg-end)
                 ("\\\\ref"             ispell-tex-arg-end)
                 ("\\\\eqref"             ispell-tex-arg-end)
                 ("\\\\label"           ispell-tex-arg-end)
                 ))
       (cadr ispell-tex-skip-alists)))

;; (defun jc-flyspell-check-next-highlighted-word ()
;;   "Custom function to spell check next highlighted word"
;;   (interactive)
;;   (flyspell-goto-next-error)
;;   (ispell-bord)
;;   )


(ace-flyspell-setup) ; binds C-. to ace-flyspell-dwim

;; Raccourcis
(global-set-key "\C-cd" 'ispell-change-dictionary)
;; (global-set-key (kbd "M-<f8>") 'jc-flyspell-check-next-highlighted-word)

(require 'flyspell-correct-helm)
(define-key flyspell-mode-map (kbd "C-;") 'flyspell-correct-previous-word-generic)
