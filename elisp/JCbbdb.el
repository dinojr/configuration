;; ~/.emacs.d/JCbbdb.el -*- mode: emacs-lisp-*-


;; file where things will be saved
;; (setq bbdb-file "~/.emacs.d/bbdb")
(add-to-list 'load-path "~/git-repositories/bbdb/lisp")
(use-package bbdb)

(add-to-list 'load-path "~/.emacs.d/bbdb-vcard")


(bbdb-initialize 'gnus 'message)
(bbdb-mua-auto-update-init 'gnus 'message)

(add-hook 'mail-setup-hook 'bbdb-mail-aliases)
(add-hook 'message-setup-hook 'bbdb-mail-aliases)

(setq bbdb-mua-update-interactive-p '(query . create))

(setq org-bbdb-anniversary-field 'birthday)

;; Raccourcis

(define-key bbdb-mode-map "r" 'bbdb-merge-records)

(defun jc-gnus-remove-field-value (field value)
  "From every record in the active bbdb database, remove the notes field whose
  name is in passed in variable"
  (message "Field: %s; Value: %s" field value)
  (mapcar
   (lambda (rec)
     (let ((val (bbdb-record-field rec field)))
       (if (string= value val)
	   (progn
	     (bbdb-record-set-field rec field nil)
	     (bbdb-change-record rec)
	     ;; (bbdb-redisplay-record rec)
	     ))))
   (bbdb-records)))

(defun jc-gnus-remove-regexp-field (field reg)
  "From every record in the active bbdb database, remove the notes field whose
  name is in passed in variable"
  (message "Field: %s; Value: %s" field reg)
  (mapcar
   (lambda (rec)
     (let ((val (bbdb-record-field rec field)))
       (message "%s" val)
       (if (not (equal nil val))
	   (progn
	     (bbdb-record-set-field rec field (replace-regexp-in-string reg "" val))
	     (bbdb-change-record rec)
	     ;; (bbdb-redisplay-record rec)
	     ))))
   (bbdb-records)))

(defun jc-gnus-remove-field (field)
  "From every record in the active bbdb database, remove the notes field whose
  name is in passed in variable"
  (message "Field: %s" field)
  (mapcar
   (lambda (rec)
     (let ((val (bbdb-record-note rec field)))
       (progn
	 (bbdb-record-set-note rec field nil)
	 (bbdb-change-record rec)
	 (bbdb-redisplay-record rec))))
   (bbdb-records)))

;; (jc-gnus-remove-field-value 'mail-alias "Importé le 18/02, myContacts")
;; (jc-gnus-remove-regexp-field 'mail-alias "myContacts")

(use-package bbdb-vcard
  :defer t)
