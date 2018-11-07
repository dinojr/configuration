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

(eyebrowse-mode t)

 (defun jc-run-command-other-frame (command)
   "Run COMMAND in a new frame."
   (interactive "CC-x 5 M-x ")
   (select-frame (make-frame))
   (call-interactively command))
(global-set-key "\C-x5\M-x" 'jc-run-command-other-frame)

 (defun jc-run-command-other-window (command)
   "Run COMMAND in a new frame."
   (interactive "CC-x 4 M-x ")
   (select-window (split-window-below))
   (call-interactively command))
(global-set-key "\C-x4\M-x" 'jc-run-command-other-window)
