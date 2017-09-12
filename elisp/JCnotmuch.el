;; ~/.emacs.d/JCnotmuch.el -*- mode: lisp-*-
(require 'notmuch)
(require 'org-gnus)

(defun jc-notmuch-file-to-group (file)
  (let ((group (directory-file-name (file-name-directory file))))
    (if (string-match "Local" group)
	(replace-regexp-in-string "/home/wilk/email/Local/" "" group)
      (let ((group (directory-file-name (file-name-directory group))))
	(setq group (replace-regexp-in-string ".*/Maildir/\\(Gmail\\|Free\\)/" "nnimap+\\1Offline:" group))
	(setq group (replace-regexp-in-string "/$" "" group))
	(if (string-match ":$" group)
	    (concat group "INBOX")
	  (replace-regexp-in-string ":\\." ":" group)))
      )
    ))

(defun jc-notmuch-goto-message-in-gnus ()
  "Open a summary buffer containing the current notmuch
  article."
  (interactive)
  (let ((group (jc-notmuch-file-to-group (notmuch-show-get-filename)))
        (message-id (replace-regexp-in-string
                     "^id:" "" (notmuch-show-get-message-id))))
    (setq message-id (replace-regexp-in-string "\"" "" message-id))
    (if (and group message-id)
        (progn 
          (switch-to-buffer "*Group*")
          (org-gnus-follow-link group message-id))
      (message "Couldn't get relevant infos for switching to Gnus."))))

(add-hook 'gnus-group-mode-hook 'jc-notmuch-shortcut)

(defun jc-notmuch-show-flag ()
  "Switch the flagged tag for the current thread or region."
  (interactive)
  (let ((tag-changes (if (member "flagged" (notmuch-show-get-tags)) (list "-flagged") (list "+flagged"))))
    (notmuch-show-tag tag-changes)))

(defun jc-notmuch-search-flag  (&optional beg end)
  "Switch the flagged tag for the current thread or region."
  (interactive)
  (let ((tag-changes (if (member "flagged" (notmuch-search-get-tags)) (list "-flagged") (list "+flagged"))))
    (notmuch-search-tag tag-changes beg end)))

(defun jc-notmuch-tree-flag ()
  "Switch the flagged tag for the current thread or region."
  (interactive)
  (let ((tag-changes (if (member "flagged" (notmuch-tree-get-tags)) (list "-flagged") (list "+flagged"))))
    (notmuch-tree-tag tag-changes)))

(define-key notmuch-show-mode-map (kbd "SPC") 'notmuch-show-flag)
(define-key notmuch-search-mode-map (kbd "SPC") 'notmuch-search-flag)
(define-key notmuch-tree-mode-map (kbd "SPC") 'notmuch-tree-flag)

(defun jc-notmuch-shortcut ()
  (define-key gnus-group-mode-map "Gg" 'notmuch-search)
  )



(define-key notmuch-show-mode-map (kbd "C-c C-c") 'jc-notmuch-goto-message-in-gnus)
