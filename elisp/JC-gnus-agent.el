;;~/.emacs.d/JC-gnus-agent.el -*- mode: lisp-*-
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Packages ;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'package)
(package-initialize)
(add-to-list 'load-path "~/configuration/elisp/")

(load "JCgnus.el")
;; (setq gnus-plugged t)
(load "JCbbdb.el")
(load "JCnamazu.el")


