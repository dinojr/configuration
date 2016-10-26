;; ~/.emacs.d/JCdesktop.el -*- mode: lisp-*-

(require 'desktop)
(desktop-save-mode 1)
(setq desktop-restore-frames t)
(add-to-list 'desktop-clear-preserve-buffers "[A-Za-z-_]+?\\(\\.org\\|\\.tex\\)")

(add-to-list 'desktop-modes-not-to-save 'dired-mode)
(add-to-list 'desktop-modes-not-to-save 'Info-mode)
(add-to-list 'desktop-modes-not-to-save 'info-lookup-mode)
(add-to-list 'desktop-modes-not-to-save 'fundamental-mode)
(add-to-list 'desktop-modes-not-to-save 'PDFView-mode)
(add-to-list 'desktop-modes-not-to-save 'Custom-mode)

(setq desktop-files-not-to-save "[A-za-z-_]+\\.synctex\\.gz")

;; (add-hook 'desktop-save-hook 'desktop-clear)

