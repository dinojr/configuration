;; ~/.emacs.d/JCnotmuch.el -*- mode: lisp-*-
(require 'notmuch)
;; (defun jc-notmuch-file-to-group (file)
;;   "Calculate the Gnus group name from the given file name.
;;   "
;;   (let ((group (file-name-directory (directory-file-name (file-name-directory file)))))
;;     ;; (setq group (replace-regexp-in-string ".*/Maildir/" "nnimap+Maildir:" group))
;;     ;; (setq group (replace-regexp-in-string "/$" "" group))
;;     ;; (if (string-match ":$" group)
;;     ;;     (concat group "INBOX")
;;     ;;   (replace-regexp-in-string ":\\." ":" group))
;;     (if (string-match "Local" group)
;; 	(replace-regexp-in-string "/home/wilk/email/Local/" "" group))
;;     )
;;   )

;; (defun jc-notmuch-goto-message-in-gnus ()
;;   "Open a summary buffer containing the current notmuch
;;   article."
;;   (interactive)
;;   (let ((group (jc-notmuch-file-to-group (notmuch-show-get-filename)))
;;         (message-id (replace-regexp-in-string
;;                      "^id:" "" (notmuch-show-get-message-id))))
;;     (setq message-id (replace-regexp-in-string "\"" "" message-id))
;;     (if (and group message-id)
;;         (progn 
;;           (switch-to-buffer "*Group*")
;;           (org-gnus-follow-link group message-id))
;;       (message "Couldn't get relevant infos for switching to Gnus."))))

;; (define-key notmuch-show-mode-map (kbd "C-c C-c") 'jc-notmuch-goto-message-in-gnus)
