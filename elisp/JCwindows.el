;; ~/.emacs.d/JCwindows.el -*- mode: lisp-*-

;; (require 'win-switch)
;; (win-switch-setup-keys-ijkl "\C-xo")
;; (setq win-switch-idle-time 1.5)

(global-set-key (kbd "C-x o") 'switch-window)
(setq switch-window-shortcut-style 'qwerty)
(setq switch-window-qwerty-shortcuts '("q" "s" "d" "f" "j" "k" "l" "m" "a" "z" "i" "o"))
