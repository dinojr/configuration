;; ~/.emacs.d/JCspellcheck.el -*- mode: emacs-lisp-*-

(use-package flyspell
  :init
  (flyspell-mode 1)
  :bind (("C-c d" . ispell-change-dictionary)
	 :map flyspell-mode-map
	 ("C-;" . flyspell-correct-previous))
  :config
  (setq ispell-program-name "aspell") ;; run flyspell with aspell, not ispell
  (setq flyspell-use-meta-tab nil)
  :hook text-mode-hook ((lambda () (ispell-change-dictionary "francais")))
  )

;; (defun jc-flyspell-check-next-highlighted-word ()
;;   "Custom function to spell check next highlighted word"
;;   (interactive)
;;   (flyspell-goto-next-error)
;;   (ispell-bord)
;;   )


;; (ace-flyspell-setup) ; binds C-. to ace-flyspell-dwim

;; Raccourcis

;; (global-set-key (kbd "M-<f8>") 'jc-flyspell-check-next-highlighted-word)


