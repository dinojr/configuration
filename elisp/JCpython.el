;; ~/.emacs.d/JCpython.el -*- mode: emacs-lisp-*-

(setenv "PYDEVD_DISABLE_FILE_VALIDATION" "1")
(setq python-shell-interpreter "python3")

;; matplotlib relies on $DISPLAY or $WAYLAND_DISPLAY to be set in order to use a GUI backend
;; see https://github.com/matplotlib/matplotlib/issues/18377
;; but an Emacs daemon started by systemd in wayland doesn't set these environemnt variables
;; although they are set by an Emacs started from within the GNOME session
(setenv "WAYLAND_DISPLAY" "wayland-0")
