;; ~/.emacs.d/JCdesktop.el -*- mode: emacs-lisp-*-

(require 'desktop)
(desktop-save-mode 1)

(if (daemonp)
    (progn
      (setq desktop-save 'if-exists)
      ())
  (setq desktop-save 'ask-if-exists))


(setq daemon-kill-emacs-hook
      '(recentf-save-list tex-delete-last-temp-files flycheck-global-teardown desktop-kill org-id-locations-save reftex-kill-emacs-hook bookmark-exit-hook-internal org-clock-save transient-maybe-save-history org-babel-remove-temporary-directory ps-kill-emacs-check server-force-stop))
