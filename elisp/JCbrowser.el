;; ~/.emacs.d/JCbrowser.el -*- mode: emacs-lisp-*-
(require 'eww)

(use-package eww-lnum
  :after eww
  :bind (:map eww-mode-map
              ("f" . eww-lnum-follow)
              ("F" . eww-lnum-universal)))

(defun choose-browser (url &rest args)
  (interactive "sURL: ")
  (if (y-or-n-p "Use external browser? ")
      (browse-url-default-browser url)
    (eww-browse-url url)))

(setq browse-url-browser-function 'choose-browser)

(global-set-key "\C-cw" 'browse-url)
