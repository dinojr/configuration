;; ~/.emacs.d/JCgpg.el -*- mode: lisp-*-


;; only query user if -*- epa-file-encrypt-to: ("j.cubizolles@free.fr"); -*- is absent 
;; "Julien Cubizolles" is working too, maybe ("Julien Cubizolles")
(setq epa-file-select-keys nil) 

(setq epa-pinentry-mode 'loopback)
