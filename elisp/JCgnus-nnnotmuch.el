;; ~/.emacs.d/JCgnus-nnnnotmuch.el -*- mode: emacs-lisp-*-
(add-to-list 'load-path "~/git-repositories/nnnotmuch/")
(require 'nnnotmuch)

(push '(nnnotmuch "") gnus-secondary-select-methods)

(setq nnnotmuch-groups
      '((""   ; Nameless server (the default Notmuch config)
         ("recent" "date:7days..")
         )
        ))

(setq nnnotmuch-program "notmuch") ; This is the default.
