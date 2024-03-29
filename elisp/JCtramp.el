;; ~/emacs.d/JCtramp.el -*- mode: emacs-lisp-*-

(require 'tramp)

(with-eval-after-load 'tramp
    ;; Allow to use: /sudo:user@host:/path/to/file
    (add-to-list 'tramp-default-proxies-alist
		 '(".*" "\\`.+\\'" "/ssh:%h:")))

(setq ange-ftp-try-passive-mode nil) ;; needed to connect to ftpperso.free.fr
