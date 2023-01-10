;; ~/.emacs.d/JCflycheck.el -*- mode: emacs-lisp-*-

(use-package flycheck
  :config
  (add-hook 'after-init-hook #'global-flycheck-mode)
  (setq flycheck-emacs-lisp-load-path 'inherit))

