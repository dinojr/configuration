;; ~/emacs.d/JCtramp.el -*- mode: lisp-*-

(require 'tramp)

(with-eval-after-load 'tramp
    ;; Allow to use: /sudo:user@host:/path/to/file
    (add-to-list 'tramp-default-proxies-alist
		 '(".*" "\\`.+\\'" "/ssh:%h:")))

