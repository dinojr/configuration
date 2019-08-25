;;~/.emacs.d/JCbibliography.el -*- mode: emacs-lisp-*-

(setq reftex-default-bibliography '("~/enseignement/papiers/bibliography.bib"))

;; see org-ref for use of these variables
(setq org-ref-bibliography-notes "~/enseignement/papiers/notes.org"
      org-ref-default-bibliography '("~/enseignement/papiers/bibliography.bib")
      org-ref-pdf-directory "~/enseignement/papiers/")

(with-eval-after-load 'helm
  (require 'helm-bibtex)
  (setq bibtex-completion-bibliography "~/enseignement/papiers/bibliography.bib")
  (setq bibtex-completion-library-path "~/enseignement/papiers/"))
