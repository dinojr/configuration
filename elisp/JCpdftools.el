;; ~/.emacs.d/JCpdftools.el -*- mode: lisp-*-

(pdf-tools-install)
(with-eval-after-load 'org
  (require 'org-pdfview)
  (add-to-list 'org-file-apps '("\\.pdf\\'" . (lambda (file link) (org-pdfview-open file))))
  (add-to-list 'org-file-apps '("\\.pdf::\\([[:digit:]]+\\)\\'" . (lambda (file link) (org-pdfview-open file))))
  )
			      
;; (setq revert-without-query (quote (".*.pdf")))

(setq pdf-view-midnight-colors '("#f8f8f2" . "#282a36"))

(add-hook 'pdf-view-mode-hook 'turn-on-auto-revert-mode 'pdf-view-midnight-minor-mode)

(setq pdf-misc-print-programm-args `("-o landscape" "-o sides=two-sided-short-edge" "-o page-ranges=1-" "-P"  ,printer-name))

;; (setq pdf-misc-print-programm-args `(,lpr-switches ,printer-name))

(setq pdf-misc-print-programm lpr-command)
