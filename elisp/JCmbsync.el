;; ~/.emacs.d/JCmbsync.el -*- mode: emacs-lisp-*-

(require 'gnus)

;; f runs the command mbsync
(require 'mbsync)
(add-hook 'mbsync-exit-hook 'gnus-group-get-new-news)
(add-hook 'mbsync-exit-hook 'notmuch-poll)
(define-key gnus-group-mode-map (kbd "f") 'mbsync)

(gnus-demon-add-handler 'mbsync 5 .5)

(defun jc-ask-run-mbsync ()
    (when (y-or-n-p "Run mbsync ? ")
      (mbsync)))

(add-hook 'gnus-before-resume-hook
	  'jc-ask-run-mbsync)

(add-hook 'gnus-exit-gnus-hook
	  'jc-ask-run-mbsync)

(add-hook 'kill-emacs-hook
	  'jc-ask-run-mbsync)

(add-hook 'gnus-suspend-gnus-hook
	  'jc-ask-run-mbsync)

(add-hook 'gnus-started-hook
	  'jc-ask-run-mbsync)

(defun jc-notify-mbsync-exit ()
  "Display a notification when a TeX run is finished."
  (notifications-notify :title "mbsync"
                        :body (format "Finished")))

(add-hook 'mbsync-exit-hook
	  #'jc-notify-mbsync-exit)


