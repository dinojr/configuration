;; ~/.emacs.d/JCwindows.el -*- mode: lisp-*-

;; (require 'win-switch)
;; (win-switch-setup-keys-ijkl "\C-xo")
;; (setq win-switch-idle-time 1.5)

;; (global-set-key (kbd "C-x o") 'switch-window)
;; (global-set-key (kbd "C-x 1") 'switch-window-then-maximize)
;; (global-set-key (kbd "C-x 2") 'switch-window-then-split-below)
;; (global-set-key (kbd "C-x 3") 'switch-window-then-split-right)
;; (global-set-key (kbd "C-x 0") 'switch-window-then-delete)
;; (setq switch-window-shortcut-style 'qwerty)
;; (setq switch-window-qwerty-shortcuts '("q" "s" "d" "f" "j" "k" "l" "m" "a" "z" "i" "o"))

(require 'ace-window)
(global-set-key (kbd "C-x o") 'ace-window)

(setq aw-keys '(?q ?s ?d ?f ?g ?h ?j ?k ?l))
(setq aw-dispatch-always t)
