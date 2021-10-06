;; ~/.emacs.d/general_stuff.el -*- mode: emacs-lisp-*-

;; Default font
(set-face-attribute 'default nil :stipple nil :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant 'normal :weight 'normal :height 110 :width 'normal :foundry "unknown" :family "DejaVu Sans Mono")

;; (set-face-attribute 'default nil :stipple nil :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant 'normal :weight 'normal :height 110 :width 'normal :foundry "unknown" :family "Droid Sans Mono")
(set-fontset-font "fontset-default" 'symbol "Noto Color Emoji")
(set-fontset-font "fontset-default" 'symbol "Symbola" nil 'append)

(add-to-list 'custom-theme-load-path "/home/wilk/git-repositories/dracula-emacs/")

(doom-themes-org-config)

(if (daemonp)
    (add-hook 'after-make-frame-functions (lambda (frame)
                        (when (eq (length (frame-list)) 2)
                            (progn
                              (select-frame frame)
                              (load-theme 'dracula t)))))
  (load-theme 'dracula t))


;; Transient-mark-mode
(setq transient-mark-mode t)
;; C-SPC C-SPC pour mettre la marque sans activer la région

;; Info directory
(require 'info)

(with-eval-after-load 'info
  
    ;; (add-to-list 'Info-directory-list "~/info/emacs/auctex/doc/")
    ;; (add-to-list 'Info-directory-list "~/info/emacs/bbdb/doc/")
    (add-to-list 'Info-directory-list "~/info/emacs/gnus/texi/")
    ;; (add-to-list 'Info-directory-list "/usr/local/share/info/")
    ;; (add-to-list 'Info-directory-list "~/info/emacs/org-mode/doc/")
    )
  
;; boxquote
(require 'boxquote)

(menu-bar-mode -1)

(scroll-bar-mode -1)

;; Tabbar
;; (require 'tabbar)
;; (tabbar-mode 0)
;; (set-face-attribute
;;  'tabbar-default nil :background "gray10" :box nil
;;  :height 100
;;  ;:foundry "bitstream" :family "Bitstream Vera Sans"
;; )
;; (set-face-attribute
;;  'tabbar-unselected nil :background "gray10" :foreground "gray50" :box nil
;; )
;; (set-face-attribute
;;  'tabbar-selected nil :background "gray30" :foreground "white" :box nil
;; )
;; (set-face-attribute
;;  'tabbar-button nil :box nil :foreground "white"
;; )
;; (set-face-attribute
;;  'tabbar-separator nil :height 0.7
;; )
;; (setq tabbar-use-images nil) 

(setq visible-bell t)

(require 'exec-path-from-shell)'
(exec-path-from-shell-initialize)

;; Raccourcis
(global-set-key [f2] 'calendar)
(global-set-key "\M-." 'find-function-at-point)

(which-key-mode)

(setq highlight-indent-guides-auto-enabled t)
(setq highlight-indent-guides-method 'column)
(setq highlight-indent-guides-responsive 'top)
(add-hook 'prog-mode-hook 'highlight-indent-guides-mode)
;; (setq oddface (color-desaturate-name "#a991f1" (* 75)))
;; (setq evenface (color-desaturate-name "#a991f1" (* 80)))
;; (setq charface (color-desaturate-name "#a991f1" (* 85)))
;; (set-face-background 'highlight-indent-guides-odd-face oddface)
;; (set-face-background 'highlight-indent-guides-even-face evenface)
;; (set-face-foreground 'highlight-indent-guides-character-face charface)

(use-package all-the-icons
  :config (add-hook 'dired-mode-hook 'all-the-icons-dired-mode))
;; M-x all-the-icons-install-fonts

(use-package beacon
  :config (beacon-mode 1))
