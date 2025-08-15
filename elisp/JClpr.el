;; ~/.emacs.d/JClpr.el -*- mode: emacs-lisp-*-

(require 'printing)

(setq printer-name "LaserJet-2100")

(setq lpr-command "lpr")

(setq lpr-switches '("-#1 -o landscape -o sides=two-sided-short-edge -o page-ranges=1-20"))
