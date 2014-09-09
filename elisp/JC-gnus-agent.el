;;~/.emacs.d/JC-gnus-agent.el -*- mode: lisp-*-
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Packages ;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'package)
(package-initialize)
(add-to-list 'load-path "~/configuration/elisp/")

(load "JCgnus.el")
(load "JCbbdb.el")
(load "JCnamazu.el")


