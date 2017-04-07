;; ~/.emacs.d/JCofflineimap.el -*- mode: lisp-*-

(with-eval-after-load 'gnus
  (add-hook 'gnus-exit-gnus-hook
	  (lambda ()
	    (when (process-live-p (get-process "offlineimap"))
	      (offlineimap-kill)))))
