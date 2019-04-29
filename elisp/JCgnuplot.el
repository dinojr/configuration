;; ~/.emacs.d/JCgnuplot.el -*- mode: lisp-*-
;; https://github.com/bruceravel/gnuplot-mode/issues/31
(use-package gnuplot
  :ensure
  :init
  (setq gnuplot-help-xpm nil)
  (setq gnuplot-line-xpm nil)
  (setq gnuplot-region-xpm nil)
  (setq gnuplot-buffer-xpm nil)
  (setq gnuplot-doc-xpm nil))
