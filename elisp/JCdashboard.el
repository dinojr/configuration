;; ~/.emacs.d/JCdashboard.el -*- mode: emacs-lisp-*-


(use-package dashboard
  :ensure t
  :config
  (dashboard-setup-startup-hook)
  (setq dashboard-startup-banner 'logo)
  (setq initial-buffer-choice (lambda () (get-buffer-create "*dashboard*"))))



