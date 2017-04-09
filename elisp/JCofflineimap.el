;; ~/.emacs.d/JCofflineimap.el -*- mode: lisp-*-

(require 'gnus)
(add-hook 'gnus-before-startup-hook
	  (lambda ()
	    (when (not (process-live-p (get-process "offlineimap")))
	    (when (y-or-n-p "Start OfflineImap ? ")
	      (offlineimap)))))
(add-hook 'gnus-before-resume-hook
	  (lambda ()
	    (when (not (process-live-p (get-process "offlineimap")))
	    (when (y-or-n-p "Start OfflineImap ? ")
	      (offlineimap)))))
(add-hook 'gnus-exit-gnus-hook
	  (lambda ()
	    (when (process-live-p (get-process "offlineimap"))
	      (when (y-or-n-p "Kill OfflineImap ? ")
		(offlineimap-kill)))))
