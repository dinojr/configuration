;; ~/.emacs.d/JCgit.el -*- mode: emacs-lisp-*-

;; Mettre le .gpg en premier assure que ce sera crypté
(setq auth-sources '("~/.authinfo.gpg" "~/.authinfo"  "~/.netrc"))

;; La ligne suivante corrige un bug de déclaration
(setq magit-log-edit-confirm-cancellation t)

(setq magit-last-seen-setup-instructions "1.4.0")
(use-package magit)
(setq magit-repository-directories '(("/home/wilk/git-repositories" . 2)
				     ("/home/wilk/texmf/tex/latex/mpsi/" . 0)
				     ("/home/wilk/configuration/" . 0)
                                     ("/home/wilk/vuibert/vuibert-sup/" . 0)
				     ("/home/wilk/centrale-2020/" . 0)))
;; (require 'magithub)
;; (require 'magit-gh-pulls) pb de dépendances avec  eieio-1.3, à réinstaller plus tard

;; n'affiche pas les commits en avance par rapport à upstream

(remove-hook 'magit-status-sections-hook 'magit-insert-unpushed-to-upstream-or-recent)
(remove-hook 'magit-status-sections-hook 'magit-insert-status-headers)

(magit-add-section-hook 'magit-status-sections-hook 'magit-insert-recent-commits)
(magit-add-section-hook 'magit-status-sections-hook 'magit-insert-status-headers)

(setq magit-repolist-columns
      '(("Name" 25 magit-repolist-column-ident nil)
	("Version" 25 magit-repolist-column-version
	 ((:sort magit-repolist-version<)))
	("U" 3 magit-repolist-column-flag
	 ((:right-align t)
	  (:sort <)))
	("B<U" 3 magit-repolist-column-unpulled-from-upstream
	 ((:right-align t)
	  (:sort  <)))
	("B>P" 3 magit-repolist-column-unpushed-to-pushremote
	 ((:right-align t)
	  (:sort <)))
	("Path" 99 magit-repolist-column-path nil)))

(setq magit-repolist-column-flag-alist
      '((magit-unstaged-files . "U")
	(magit-staged-files . "S")
	(magit-untracked-files . "T")))

(defun jc-display-git-status ()
  (interactive)
  (select-frame (make-frame))
  (magit-status-internal "/home/wilk/configuration/")
  (delete-other-windows)
  (magit-status-internal "/home/wilk/git-repositories/")
  (magit-status-internal "/home/wilk/texmf/tex/latex/mpsi")
  (magit-status-internal "/home/wilk/centrale-2020")
  (magit-status-internal "/home/wilk/vuibert/vuibert-sup/.")
  )

(global-set-key [f6] 'jc-display-git-status)
