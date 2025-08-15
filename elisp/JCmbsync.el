;; ~/.emacs.d/JCmbsync.el -*- mode: emacs-lisp-*-

(require 'gnus)

;; f runs the command mbsync
(require 'mbsync)
;; (add-hook 'mbsync-exit-hook 'gnus-group-get-new-news)
(add-hook 'mbsync-exit-hook 'notmuch-poll)
(define-key gnus-group-mode-map (kbd "f") 'mbsync)



;; (gnus-demon-add-handler 'mbsync 5 .5)


(gnus-demon-add-handler 'jc-run-mbsync-if-nm-up 5 .5)

(defun jc-run-mbsync-if-nm-up()
  (when (nm-is-connected)
    (mbsync)))

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
  "Display a notification when a mbsync run is finished."
  (notifications-notify :title "mbsync"
                        :body (format "Finished")))

(add-hook 'mbsync-exit-hook
	  #'jc-notify-mbsync-exit)


