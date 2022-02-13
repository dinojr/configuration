;; ~/.emacs.d/JCpackages.el -*- mode: emacs-lisp-*-
(require 'package)
(require 'paradox)
(eval-after-load "paradox"
  (progn
    '(setq paradox-automatically-star nil)
    '(setq paradox-github-token t)
    '(load "paradox-token"))
  )

(setq package-archives '(("melpa" . "https://melpa.org/packages/")
			 ("gnu" . "https://elpa.gnu.org/packages/")
			 ;; ("org" . "https://orgmode.org/elpa/")
			 ;; ("marmalade" . "https://marmalade-repo.org/packages/")
			  ;; ("sunrise" . "http://joseito.republika.pl/sunrise-commander/")
			 ))

(setq package-archive-priorities
      '(("melpa" . 20)
        ("org" . 10)
        ("gnu" . 0)))

(setq paradox-execute-asynchronously t)

(defun jc-do-package-management (&optional delete)
  (and (byte-recompile-directory (expand-file-name "~/.emacs.d/elpa/"))
       (byte-recompile-directory (expand-file-name "~/git-repositories/"))
       (paradox-upgrade-packages)
       (package-autoremove)
       (package-install-selected-packages)
       (if delete (delete-frame))))

(defun jc-ask-package-management ()
  (interactive)
  (when (y-or-n-p "Package-management")
    (jc-do-package-management t)
    ))

;; emacsclient -c -F '((minibuffer . only)(name . "Packages")(height . 2))' -e '(jc-ask-package-management)'
