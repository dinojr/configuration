;; ~/.emacs.d/JCpdftools.el -*- mode: lisp-*-

(pdf-tools-install)
(eval-after-load 'org '(progn (require 'org-pdfview)
			      (add-to-list 'org-file-apps '("\\.pdf\\'" . (lambda (file link) (org-pdfview-open file))))
			      (add-to-list 'org-file-apps '("\\.pdf::\\([[:digit:]]+\\)\\'" . (lambda (file link) (org-pdfview-open file))))
			      ))
			      

(setq revert-without-query (quote (".*.pdf")))

(setq pdf-view-midnight-colors '("#f8f8f2" . "#282a36"))

(add-hook 'pdf-view-mode-hook 'pdf-view-midnight-minor-mode)
