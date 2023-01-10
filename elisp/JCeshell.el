;;~/.emacs.d/JCeshell.el -*- mode: emacs-lisp-*-

;; (eshell/addpath "-b" "~/bin/" "/usr/local/texlive/current/bin/x86_64-linux")

;; (setq exec-path (append exec-path '("~/bin/" "/usr/local/texlive/current/bin/x86_64-linux/")))
;; (setenv "PATH" (concat (getenv "PATH") ":~/bin/" ":/usr/local/texlive/current/bin/x86_64-linux/"))


(use-package exec-path-from-shell
  :config (exec-path-from-shell-initialize))

(use-package eshell-syntax-highlighting
  :after esh-mode
  :demand t ;; Install if not already installed.
  :config
  ;; Enable in all Eshell buffers.
  (eshell-syntax-highlighting-global-mode +1))
