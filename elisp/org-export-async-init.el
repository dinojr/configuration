;;~/.emacs -*- mode: lisp-*-

;; org est installé avec melpa
(require 'package)
(package-initialize)

(add-to-list 'load-path "~/configuration/elisp/")
(load "JCorg.el")
(require 'ox)
(load "JClatex.el")
