;;~/.emacs.d/JCeshell.el -*- mode: lisp-*-

;; (eshell/addpath "-b" "~/bin/" "/usr/local/texlive/current/bin/x86_64-linux")

(setq exec-path (append exec-path '("~/bin/" "/usr/local/texlive/current/bin/x86_64-linux/")))
(setenv "PATH" (concat (getenv "PATH") ":~/bin/" ":/usr/local/texlive/current/bin/x86_64-linux/"))
