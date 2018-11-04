;; ~/.emacs.d/JCminions-moody.el -*- mode: lisp-*-
(require 'package)
(package-initialize)
(setq sml/theme 'dark)
(smart-mode-line-enable)
(use-package moody
  :config
  (setq x-underline-at-descent-line t)
  (moody-replace-mode-line-buffer-identification)
  (moody-replace-vc-mode))

(moody-replace-sml/mode-line-buffer-identification)

(use-package minions
  :ensure t
  :init (minions-mode)
  :config
  (setq
   minions-mode-line-lighter "#"
   minions-direct '(flycheck-mode
		    mingus-mode-line-objet)
   ))


;; (require 'xpm) ;; for major-mode-icons
;; (use-package major-mode-icons
;;   :ensure t
;;   :config
;;   (major-mode-icons-mode 1))

;; (setq
;;  mode-line-end-spaces
;;  (quote
;;   ((:eval
;;     (major-mode-icons/show))
;;     )))
