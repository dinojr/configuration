;; ~/.emacs.d/JClookup.el -*- mode: emacs-lisp-*-

;; Helm-dash uses the same docsets as Dash. You can install them with
;; m-x helm-dash-install-docset for the official docsets or m-x
;; helm-dash-install-user-docset for user contributed docsets
;; (experimental).

(eval-after-load 'helm
  '(progn
     (require 'helm-xref)
     (if (< emacs-major-version 27)
	 (setq xref-show-xrefs-function 'helm-xref-show-xrefs)
       (setq xref-show-xrefs-function 'helm-xref-show-xrefs-27))
     (require 'helm-dash)))

