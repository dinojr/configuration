;; ~/.emacs.d/general_stuff.el -*- mode: lisp-*-

;; Default font
(set-face-attribute 'default nil :stipple nil :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant 'normal :weight 'normal :height 100 :width 'normal :foundry "unknown" :family "DejaVu Sans Mono")


;; Theme, dans melpa maintenant
;; (add-to-list 'load-path "/home/wilk/.emacs.d/naquadah-theme")
;; (require 'naquadah-theme)
(require 'dracula-theme)


;; Transient-mark-mode
(setq transient-mark-mode t)
;; C-SPC C-SPC pour mettre la marque sans activer la région

;; Info directory
(require 'info)

(eval-after-load "info"
  '(progn
    (add-to-list 'Info-directory-list "~/info/emacs/auctex/doc/")
    (add-to-list 'Info-directory-list "~/info/emacs/bbdb/doc/")
    (add-to-list 'Info-directory-list "~/info/emacs/gnus/texi/")
    (add-to-list 'Info-directory-list "/usr/local/share/info/")
    (add-to-list 'Info-directory-list "~/info/emacs/org-mode/doc/")
    )
  )

;; boxquote
(require 'boxquote)

;; Tabbar
(require 'tabbar)
(tabbar-mode 1)
(set-face-attribute
 'tabbar-default nil :background "gray10" :box nil
 :height 100
 ;:foundry "bitstream" :family "Bitstream Vera Sans"
)
(set-face-attribute
 'tabbar-unselected nil :background "gray10" :foreground "gray50" :box nil
)
(set-face-attribute
 'tabbar-selected nil :background "gray30" :foreground "white" :box nil
)
(set-face-attribute
 'tabbar-button nil :box nil :foreground "white"
)
(set-face-attribute
 'tabbar-separator nil :height 0.7
)
(setq tabbar-use-images nil) 

;; Raccourcis
(global-set-key [f2] 'calendar)
