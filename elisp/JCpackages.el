;; ~/.emacs.d/JCpackages.el -*- mode: lisp-*-
(require 'package)
(require 'paradox)
(eval-after-load "paradox"
  (progn
    '(setq paradox-automatically-star nil)
    '(setq paradox-github-token t)
    '(load "paradox-token"))
  )

(setq package-archives '(("ELPA" . "http://tromey.com/elpa/")
			 ("melpa" . "https://melpa.org/packages/")
			 ("gnu" . "http://elpa.gnu.org/packages/")
			 ("org" . "http://orgmode.org/elpa/")
			 ;; ("marmalade" . "https://marmalade-repo.org/packages/")
			  ;; ("sunrise" . "http://joseito.republika.pl/sunrise-commander/")
			 ))

(defun jc-do-package-management ()
  (byte-recompile-directory (expand-file-name "~/.emacs.d/elpa/"))
  (byte-recompile-directory (expand-file-name "~/git-repositories/"))
  (paradox-upgrade-packages)
  (package-autoremove)
  (package-install-selected-packages))

(defun jc-ask-package-management ()
  (when (y-or-n-p "Package-management")
    (jc-do-package-management)
    ))

(add-hook 'server-after-make-frame-hook 'jc-ask-package-management)

