;;~/.emacs -*- mode: lisp-*-

;; si org est installé avec melpa
;; (require 'package)
;; (package-initialize)

;; si org est installé avec git
(add-to-list 'load-path (expand-file-name "~/info/emacs/org-mode/lisp"))
(add-to-list 'load-path (expand-file-name  "~/info/emacs/org-mode/contrib/lisp"))

(require 'org)
(require 'ox)
(add-to-list 'load-path "~/configuration/elisp/")
(load "JCorg.el")
(load "JClatex.el")
