;; ~/.emacs.d/JClpr.el -*- mode: lisp-*-


;; file where things will be saved
;; (setq bbdb-file "~/.emacs.d/bbdb")

(require 'printing)

(setq printer-name "laserjet-syn")

(setq lpr-command "lpr")

(setq lpr-switches '("-#1 -o landscape -o sides=two-sided-short-edge -o page-ranges=1-"))
