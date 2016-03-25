;;~/.emacs.d/JCbibliography.el -*- mode: lisp-*-

(eval-after-load 'helm
  (lambda ()
    (require 'helm-bibtex)
    (setq helm-bibtex-bibliography '("/home/wilk/enseignement/papiers/bibliography.bib"))
    (setq helm-bibtex-library-path '("/home/wilk/enseignement/papiers/"))))
