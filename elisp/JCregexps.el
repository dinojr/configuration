;; ~/.emacs.d/JCregexps.el -*- mode: lisp-*-

;; (defun jc-replace-regexp-in-region (Begin End from to)
;;   "Replace from by to in the selected region"
;;   (interactive "r")
;;   (let ((deactivate-mark nil))
;;     (query-replace-regexp from to nil Begin End)
;;     ;; (setq deactivate-mark nil)
;;     ))

(defun jc-replace-regexp-in-region (Begin End from to)
  (interactive "r")
  (save-excursion
    (let ((deactivate-mark nil))
      (goto-char (min Begin End))
      (while (re-search-forward from End t)
	(replace-match to nil nil)))))

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

(defun jc-unit-to-si (Begin End)
  "Replace \\unit[1234]{unite} by \\SI{1234}{\\unite}"
  (interactive "r")
  ;; (jc-replace-regexp-in-region Begin End "\\\\unit\\[\\([[:ascii:]]+?\\)\\]{\\([[:ascii:]]+?\\)}" "\\\\SI{\\1}{\\\\\2\\?}")
  (let (deactivate-mark)
    (query-replace-regexp "\\\\unit\\[\\([[:ascii:]]+?\\)\\]{\\([[:ascii:]]+?\\)}" "\\\\SI{\\1}{\\\\\\2\\?}" nil Begin End))
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
  (jc-replace-regexp-in-region Begin End "\\\\begin{block}\\(<.*?>\\)?{\\(.*?\\)}\\([\\ \n\t [:nonascii:] [:ascii:]]*?\\)\\\\end{block}" "\\\\begin{Consequence}\[\\2\]\\3\n\\\\end{Consequence}")
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

(defun jc-do-all-regexps (Begin End)
  (interactive "r")
  (let ((deactivate-mark nil))
    (jc-alert-or-emph-to-stars Begin End)
    (jc-dollar-to-paren Begin End)
    (jc-item-to-plus Begin End)
    (jc-unit-to-si Begin End))
  )

(defun jc-add-and-configure-entry ()
  (interactive)
  (save-excursion
    (org-beamer-select-environment)
    (org-set-tags-command)
    (condition-case nil
        (while t
          (call-interactively 'org-set-property))
      (quit nil))
    )
  )

(defun my-increment-number-decimal (&optional arg)
  "Increment the number forward from point by 'arg'."
  (interactive "p*")
  (save-excursion
    (save-match-data
      (let (inc-by field-width answer)
        (setq inc-by (if arg arg 1))
        (skip-chars-backward "0123456789")
        (when (re-search-forward "[0-9]+" nil t)
          (setq field-width (- (match-end 0) (match-beginning 0)))
          (setq answer (+ (string-to-number (match-string 0) 10) inc-by))
          (when (< answer 0)
            (setq answer (+ (expt 10 field-width) answer)))
          (replace-match (format (concat "%0" (int-to-string field-width) "d")
                                 answer)))))))

(define-prefix-command 'jc-regexps)
;; (global-set-key (kbd "C-!") 'jc-regexps)
(define-key org-mode-map (kbd "C-!") 'jc-regexps)
(define-key LaTeX-mode-map (kbd "C-!") 'jc-regexps)
(define-key jc-regexps (kbd "a") 'jc-alert-or-emph-to-stars)
(define-key jc-regexps (kbd "d") 'jc-dollar-to-paren)
(define-key jc-regexps (kbd "b") 'jc-block-to-heading)
(define-key jc-regexps (kbd "k") 'jc-block-to-consequence)
(define-key jc-regexps (kbd "o") 'jc-only-to-heading)
(define-key jc-regexps (kbd "i") 'jc-item-to-plus)
(define-key jc-regexps (kbd "s") 'jc-unit-to-si)
(define-key jc-regexps (kbd "r") 'jc-do-all-regexps)

(define-key jc-regexps (kbd "n") 'jc-add-and-configure-entry)





;; Replacement without prompt
;; (defun test_gen (begin end from to)
;;   (save-excursion
;;     (save-restriction
;;       (let (deactivate-mark)
;; 	(narrow-to-region begin end)
;; 	(goto-char (point-min))
;; 	(while  (re-search-forward from end t)
;; 	  (replace-match to)))
;;       )))

;; Replacement with prompt but the excursion is messed up
;; (defun test_gen (begin end from to)
;;   (save-excursion
;;     (save-restriction
;;       (let (deactivate-mark)
;; 	(narrow-to-region begin end)
;; 	(goto-char (point-min))
;; 	(while  (re-search-forward from end t)
;; 	  (replace-match-maybe-edit to t nil nil (match-data) nil)))
;;       )))

;; (defun test_alert (begin end)
;;   (interactive "r")
;;   (test_gen begin end "\\\\\\(alert\\|emph\\){\\(.+?\\)}" "*\\2*")
;;   )
