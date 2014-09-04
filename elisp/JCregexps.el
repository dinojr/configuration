;; ~/.emacs.d/JCregexps.el -*- mode: lisp-*-

(defun jc-alert-or-emph-to-stars ()
  "Replace \\alert{toto} or \\emph{toto} by *toto*"
  (interactive)
  (query-replace-regexp "\\\\\\(alert\\|emph\\){\\(.+?\\)}" "*\\2*")
  )

(defun jc-item-to-plus ()
  "Replace \\item by +"
  (interactive)
  (query-replace-regexp "\\\\item" "+")
  )

(defun jc-block-to-heading ()
  "Replace \\begin{block}toto\\end{block} by toto"
  (interactive)
  (query-replace-regexp "\\\\begin{block}{\\(.*?\\)}\\([\\ \n\t [:nonascii:] [:ascii:]]*?\\)\\\\end{block}" "* \\1\n\\2")
  )

(defun jc-block-to-consequence ()
  "Replace \\begin{block}<something>{Titre}toto\\end{block} by \\begin{consequence}[Titre]toto\\end{consequence}"
  (interactive)
  (query-replace-regexp "\\\\begin{block}\\(<.*?>\\)?{\\(.*?\\)}\\([\\ \n\t [:nonascii:] [:ascii:]]*?\\)\\\\end{block}" "\\\\begin{consequence}\[\\2\]\\3\n\\\\end{consequence}")
  )

(defun jc-dollar-to-paren ()
  "Replace $toto$ by \\(toto\\)"
  (interactive)
  (query-replace-regexp "\\$\\([\n\t [:nonascii:] [:ascii:]]+?\\)\\$" "\\\\\(\\1\\\\\)")
  )

(defun jc-only-to-heading ()
  "Replace \\only<act>{toto} by 
     * Titre
       :PROPERTIES:
       :BEAMER_env: action
       :BEAMER_ACT: only@act
       :END:"
  (interactive)
  (query-replace-regexp "\\\\only<\\(.*?\\)>{\\([ \n \t [:ascii:] [:nonascii:]]*\\)}" "* \?\n\t:PROPERTIES:\n\t:BEAMER_env: action\n\t:BEAMER_ACT: only@\\1\n\t:END:\n\n\t\\2")
  )

(defun jc-do-all-regexps ()
  (interactive)
  (lambda ()
    (jc-alert-or-to-stars)
    (jc-dollar-to-paren)
    (jc-item-to-plus))
    )
(define-prefix-command 'jc-regexps)
(global-set-key (kbd "C-!") 'jc-regexps)
(define-key jc-regexps (kbd "a") 'jc-alert-or-emph-to-stars)
(define-key jc-regexps (kbd "d") 'jc-dollar-to-paren)
(define-key jc-regexps (kbd "b") 'jc-block-to-heading)
(define-key jc-regexps (kbd "o") 'jc-only-to-heading)
(define-key jc-regexps (kbd "i") 'jc-item-to-plus)
