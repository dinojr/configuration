;; ~/.emacs.d/JCgpg.el -*- mode: emacs-lisp-*-

;; only query user if -*- epa-file-encrypt-to: ("j.cubizolles@free.fr"); -*- is absent 
;; "Julien Cubizolles" is working too, maybe ("Julien Cubizolles")
(require 'epa-file)
(epa-file-enable)

;; https://www.emacswiki.org/emacs/EasyPG#toc5
(defun jc/kludge-gpg-agent
    ()
  (if
      (display-graphic-p)
      (setenv "DISPLAY"
              (terminal-name))
    (setenv "GPG_TTY"
            (terminal-name))
    (setenv "DISPLAY")))

(add-hook 'window-configuration-change-hook 'jc/kludge-gpg-agent)
(setq epa-file-select-keys nil)
(setq epa-pinentry-mode 'loopback)
