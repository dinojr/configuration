;; ~/.emacs.d/JCbbdb.el -*- mode: lisp-*-


;; file where things will be saved
;; (setq bbdb-file "~/.emacs.d/bbdb")

(require 'bbdb)

(add-to-list 'load-path "/home/wilk/.emacs.d/bbdb-vcard")

(bbdb-initialize 'gnus 'message)
(bbdb-mua-auto-update-init 'gnus 'message)

(add-hook 'mail-setup-hook 'bbdb-mail-aliases)
(add-hook 'message-setup-hook 'bbdb-mail-aliases)

(setq bbdb-mua-update-interactive-p '(query . create))

(require 'org-bbdb)

;;; Return list of anniversaries for today and the next n (default: 7) days.
;;; This is meant to be used in an org file instead of org-bbdb-anniversaries:
;;;
;;; %%(my-anniversaries)
;;;
;;; or
;;; %%(my-anniversaries 3)
;;;
;;; to override the 7-day default.

 (defun date-list (date &optional n)
   "Return a list of dates in (m d y) format from 'date' to n days hence."
   (if (not n) (setq n 7))
   (let ((abs (calendar-absolute-from-gregorian date))
         (i 0)
         ret)
     (while (<= i n)
       (setq ret (cons (calendar-gregorian-from-absolute (+ abs i)) ret))
       (setq i (1+ i)))
     (reverse ret)))

 (defun annotate-link-with-date (d l)
   "Annotate text of each element of l with the anniversary date.
   The assumption is that the text is a bbdb link  of the form
   [[bbdb:name][Description]] and the annotation
   is added to the description."
   (let ((f (lambda (x)
              (string-match "]]" x)
              (replace-match (format " -- %d-%d-%d\\&" (caddr d) (car d) (cadr d)) nil nil x))))
     (mapcar f l)))

 (defun my-anniversaries (&optional n)
   "Return list of anniversaries for today and the next n days (default 7).
 'date' is dynamically bound."
   (let ((dates (date-list date n))
         (f (lambda (d) (let ((date d)) (annotate-link-with-date d (org-bbdb-anniversaries))))))
     (delete nil (mapcan f dates))))

(setq org-bbdb-anniversary-field 'birthday)

;; Raccourcis

(define-key bbdb-mode-map "r" 'bbdb-merge-records)

;; (defun remove-field-value (field value)
;;   "From every record in the active bbdb database, remove the notes field whose
;;   name is in passed in variable"
;;   (message "Field: %s; Value: %s" field value)
;;   (mapcar
;;    (lambda (rec)
;;      (let ((val (bbdb-record-note rec field)))
;;        (if (string= value val)
;; 	   (progn
;; 	     (bbdb-record-set-note rec field nil)
;; 	     (bbdb-change-record rec)
;; 	     (bbdb-redisplay-record rec)))))
;;    (bbdb-records)))

;; (defun remove-field (field)
;;   "From every record in the active bbdb database, remove the notes field whose
;;   name is in passed in variable"
;;   (message "Field: %s" field)
;;   (mapcar
;;    (lambda (rec)
;;      (let ((val (bbdb-record-note rec field)))
;; 	   (progn
;; 	     (bbdb-record-set-note rec field nil)
;; 	     (bbdb-change-record rec)
;; 	     (bbdb-redisplay-record rec))))
;;    (bbdb-records)))

;(remove-field-value 'folder "default")
