;; ~/.emacs.d/JCpackages.el -*- mode: emacs-lisp-*-
(require 'package)
(setq async-bytecomp-package-mode t)
(setq package-menu-async t)

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

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(eval-and-compile
  (setq use-package-always-ensure t
        use-package-expand-minimally t))

(defun jc-do-package-management (&optional delete)
  (and (byte-recompile-directory (expand-file-name "~/.emacs.d/elpa/"))
       (byte-recompile-directory (expand-file-name "~/git-repositories/"))
       (package-autoremove)
       (package-install-selected-packages)
       (if delete (delete-frame))))

(defun jc-ask-package-management ()
  (interactive)
  (when (y-or-n-p "Package-management")
    (jc-do-package-management t)
    ))

;; emacsclient -c -F '((minibuffer . only)(name . "Packages")(height . 2))' -e '(jc-ask-package-management)'
