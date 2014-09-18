;;~/.emacs -*- mode: lisp-*-

;; org est installé avec melpa
(require 'package)
(package-initialize)

(add-to-list 'load-path "~/configuration/elisp/")
(load "JCorg.el")
(require 'ox)
(setq org-export-async-init-file "/home/wilk/configuration/elisp/org-export-async-init.el")
(load "JClatex.el")
