;; ~/emacs.d/JCtramp.el -*- mode: lisp-*-

(require 'tramp)

(eval-after-load 'tramp
 '(progn
    ;; Allow to use: /sudo:user@host:/path/to/file
    (add-to-list 'tramp-default-proxies-alist
		 '(".*" "\\`.+\\'" "/ssh:%h:"))))

