;; ~/.emacs.d/JCnetwork.el -*- mode: emacs-lisp-*-
(defun nm-is-connected()
  (equal 70 (dbus-get-property
             :system "org.freedesktop.NetworkManager" "/org/freedesktop/NetworkManager"
             "org.freedesktop.NetworkManager" "State")))

