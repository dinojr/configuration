;; ~/.emacs.d/JCregexps.el -*- mode: lisp-*-

(defun jc-replace-regexp-in-region (Begin End from to)
  "Replace from by to in the selected region"
  ;; (interactive "r")
  (save-excursion
    (let (deactivate-mark)
      (query-replace-regexp from to nil Begin End)))
  )

(defun jc-dollar-to-paren (Begin End)
  "Replace $toto$ by \\(toto\\) in selected region"
  (interactive "r")
  (jc-replace-regexp-in-region Begin End "\\$\\([\n\t [:nonascii:] [:ascii:]]+?\\)\\$" "\\\\\(\\1\\\\\)")
  )

(defun jc-alert-or-emph-to-stars (Begin End)
  "Replace \\alert{toto} or \\emph{toto} by *toto*"
  (interactive "r")
  (jc-replace-regexp-in-region Begin End "\\\\\\(alert\\|emph\\){\\(.+?\\)}" "*\\2*")
  )

(defun jc-item-to-plus (Begin End)
  "Replace \\item by +"
  (interactive "r")
  (jc-replace-regexp-in-region Begin End "\\\\item\\(\\[\\([[:ascii:]]*\\)\\]\\)?" "+")
  ;; (jc-replace-regexp-in-region Begin End "\\\\item\\(\\[\\([[:ascii:]]*\\)\\]\\)?" (if (equal \2 nil) "+" (concat "+ " \2 " ::")))
  )

(defun jc-block-to-heading (Begin End)
  "Replace \\begin{block}toto\\end{block} by toto"
  (interactive "r")
  (query-replace-regexp "\\\\begin{block}{\\(.*?\\)}\\([\\ \n\t [:nonascii:] [:ascii:]]*?\\)\\\\end{block}" "* \\1\n\\2")
  )

(defun jc-block-to-consequence (Begin End)
  "Replace \\begin{block}<something>{Titre}toto\\end{block} by \\begin{Consequence}[Titre]toto\\end{Consequence}"
  (interactive "r")
  (jc-replace-regexp-in-region Begin End "\\\\begin{block}\\(<.*?>\\)?{\\(.*?\\)}\\([\\ \n\t [:nonascii:] [:ascii:]]*?\\)\\\\end{block}" "\\\\begin{consequence}\[\\2\]\\3\n\\\\end{consequence}")
  )

(defun jc-only-to-heading (Begin End)
  "Replace \\only<act>{toto} by 
     * Titre
       :PROPERTIES:
       :BEAMER_env: action
       :BEAMER_ACT: only@act
       :END:"
  (interactive "r")
  (jc-replace-regexp-in-region Begin End "\\\\only<\\(.*?\\)>{\\([ \n \t [:ascii:] [:nonascii:]]*\\)}" "* \?\n\t:PROPERTIES:\n\t:BEAMER_env: action\n\t:BEAMER_ACT: only@\\1\n\t:END:\n\n\t\\2")
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
