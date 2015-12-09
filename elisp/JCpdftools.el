;; ~/.emacs.d/JCpdftools.el -*- mode: lisp-*-

(pdf-tools-install)
(eval-after-load 'org '(progn (require 'org-pdfview)
			      (add-to-list 'org-file-apps '("\\.pdf\\'" . org-pdfview-open))
			      (add-to-list 'org-file-apps '("\\.pdf::\\([[:digit:]]+\\)\\'" . org-pdfview-open))))

(setq revert-without-query (quote (".*.pdf")))
