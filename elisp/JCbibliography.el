;;~/.emacs.d/JCbibliography.el -*- mode: lisp-*-

(setq reftex-default-bibliography '("~/enseignement/papiers/bibliography.bib"))

;; see org-ref for use of these variables
(setq org-ref-bibliography-notes "~/enseignement/papiers/notes.org"
      org-ref-default-bibliography '("~/enseignement/papiers/bibliography.bib")
      org-ref-pdf-directory "~/enseignement/papiers/")

(eval-after-load 'helm
  (lambda ()
    (require 'helm-bibtex)
    (setq bibtex-completion-bibliography "~/enseignement/papiers/bibliography.bib")
    (setq bibtex-completion-library-path "~/enseignement/papiers/")))
