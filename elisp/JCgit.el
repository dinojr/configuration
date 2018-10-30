;; ~/.emacs.d/JCgit.el -*- mode: lisp-*-

;; La ligne suivante corrige un bug de déclaration
(setq magit-log-edit-confirm-cancellation t)

(setq magit-last-seen-setup-instructions "1.4.0")
(require 'magit)
(setq magit-repository-directories '(("/home/wilk/" . 1)
				     ("/home/wilk/texmf/tex/latex/mpsi/" . 0)
                                     ("/home/wilk/vuibert/vuibert-sup/" . 0)))
;; (require 'magithub)
;; (require 'magit-gh-pulls) pb de dépendances avec  eieio-1.3, à réinstaller plus tard

;; n'affiche pas les commits en avance par rapport à upstream
(setq magit-status-sections-hook (delete 'magit-insert-unpushed-to-upstream magit-status-sections-hook))
(magit-add-section-hook 'magit-status-sections-hook
			'magit-insert-modules-unpulled-from-upstream
			'magit-insert-unpushed-to-pushremote
			'magit-insert-modules-unpushed-to-pushremote)

(defun jc-display-git-status ()
  (interactive)
  (select-frame (make-frame))
  (magit-status-internal "/home/wilk/configuration/")
  (delete-other-windows)
  (magit-status-internal "/home/wilk/git-repositories/")
  (magit-status-internal "/home/wilk/texmf/tex/latex/mpsi")
  (magit-status-internal "/home/wilk/vuibert/vuibert-sup/.")
  )

(global-set-key [f6] 'jc-display-git-status)
