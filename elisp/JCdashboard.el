;; ~/.emacs.d/JCdashboard.el -*- mode: emacs-lisp-*-


(use-package dashboard
  :ensure t
  :config
  (dashboard-setup-startup-hook)
  (setq initial-buffer-choice (lambda () (get-buffer-create "*dashboard*"))))


