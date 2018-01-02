;; ~/.emacs.d/JCbbdb.el -*- mode: lisp-*-


;; file where things will be saved
;; (setq bbdb-file "~/.emacs.d/bbdb")
(add-to-list 'load-path "~/git-repositories/bbdb/lisp")
(require 'bbdb)

(add-to-list 'load-path "~/.emacs.d/bbdb-vcard")


(bbdb-initialize 'gnus 'message)
(bbdb-mua-auto-update-init 'gnus 'message)

(add-hook 'mail-setup-hook 'bbdb-mail-aliases)
(add-hook 'message-setup-hook 'bbdb-mail-aliases)

(setq bbdb-mua-update-interactive-p '(query . create))

(require 'org-bbdb)


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
