;; ~/.emacs.d/JCofflineimap.el -*- mode: lisp-*-

(with-eval-after-load 'gnus
  (add-hook 'gnus-before-startup-hook
	  (lambda ()
	    (when (y-or-n-p "Start OfflineImap ? ")
	      (offlineimap))))
  (add-hook 'gnus-exit-gnus-hook
	  (lambda ()
	    (when (process-live-p (get-process "offlineimap"))
	      (when (y-or-n-p "Kill OfflineImap ? ")
		(offlineimap-kill)))))
