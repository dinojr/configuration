;;~/.emacs -*- mode: lisp-*-
;; (setq org-export-async-debug t)
;; si org est installé avec melpa
;; (require 'package)
;; (package-initialize)

(require 'package) ;; org-ref is loaded through melpa
(package-initialize)

;; si org est installé avec git
(add-to-list 'load-path "~/git-repositories/org-mode/lisp")
(add-to-list 'load-path "~/git-repositories/org-mode/contrib/lisp")

(require 'org)
(require 'ox)
(require 'ox-beamer)

(add-to-list 'load-path "~/configuration/elisp/")
(load "JCorg.el")
(load "JClatex.el")
