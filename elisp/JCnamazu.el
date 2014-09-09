;; ~/.emacs.d/JCnamazu.el -*- mode: lisp-*-

;; Pour Namazu
(add-to-list 'load-path "~/info/emacs/gnus/contrib")

(require 'gnus-namazu)
;; (setq gnus-namazu-index-directories '("/home/wilk/Mail/namazu/"))
(setq gnus-namazu-index-directories '("/home/wilk/News/namazu/"))
(gnus-namazu-insinuate)
;; (setq gnus-namazu-make-index-command "mknmz")
(setq gnus-namazu-make-index-arguments
      '("--all" "--mailnews" "--deny=^.*[^0-9].*$" "--exclude=(Junk)")) 
