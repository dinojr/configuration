;; ~/.emacs.d/JCofflineimap.el -*- mode: lisp-*-

(require 'gnus)

(defun jc-ask-start-offlineimap ()
  (when (not (process-live-p (get-process "offlineimap")))
    (when (y-or-n-p "Start OfflineImap ? ")
      (offlineimap))))

(defun jc-ask-kill-offlineimap ()
  (when (process-live-p (get-process "offlineimap"))
    (when (y-or-n-p "Kill OfflineImap ? ")
      (offlineimap-kill))))

(defun jc-kill-offlineimap ()
  (when (process-live-p (get-process "offlineimap"))
    (offlineimap-kill)))
  
(add-hook 'gnus-before-startup-hook
	  'jc-ask-start-offlineimap)

(add-hook 'gnus-before-resume-hook
	  'jc-ask-start-offlineimap)

(add-hook 'gnus-exit-gnus-hook
	  'jc-ask-kill-offlineimap)

(add-hook 'kill-emacs-hook
	  'jc-kill-offlineimap)

(add-hook 'gnus-suspend-gnus-hook
	  'jc-kill-offlineimap)

