;; ~/emacs.d/JCdired.el -*- mode: lisp-*-

(add-to-list 'load-path "/home/wilk/.emacs.d/dired-toggle-sudo/")

(require 'dired)
(when (require 'dired-aux)
 (require 'dired-async))

(eval-after-load "dired"
  '(define-key dired-mode-map "z" 'jc-dired-zip-files))
(defun jc-dired-zip-files (zip-file)
  "Create an archive containing the marked files."
  (interactive "Enter name of zip file: ")

  ;; create the zip file
  (let ((zip-file (if (string-match ".zip$" zip-file) zip-file (concat zip-file ".zip"))))
    (shell-command 
     (concat "zip " 
             zip-file
             " "
             (concat-string-list 
              (mapcar
               '(lambda (filename)
                  (file-name-nondirectory filename))
               (dired-get-marked-files))))))

  (revert-buffer)

  ;; remove the mark on all the files  "*" to " "
  ;; (dired-change-marks 42 ?\040)
  ;; mark zip file
  ;; (dired-mark-files-regexp (filename-to-regexp zip-file))
  )

(add-hook 'dired-mode-hook 'turn-on-gnus-dired-mode)

(defun concat-string-list (list) 
   "Return a string which is a concatenation of all elements of the list separated by spaces" 
    (mapconcat '(lambda (obj) (format "%s" obj)) list " "))

(require 'dired-toggle-sudo)

(defun jc-dired-find-file-latex ()
  "In Dired, visit this file or directory and switch to workgroup latex"
  (interactive)
  (let 
      ((file (dired-get-file-for-visit)))
    (jc-switch-to-workgroup "latex")
    (find-file file)
    )
  )

(add-hook 'dired-mode-hook 'jc-ido-dired-mode-hook)

(defun jc-dired-open-file ()
  "In dired, open the file named on this line."
  (interactive)
  (let* ((file (dired-get-filename nil t)))
    (message "Opening %s..." file)
    (call-process "gnome-open" nil 0 nil file)
    (message "Opening %s done" file)))

(add-hook 'dired-mode-hook 'dired-hide-details-mode)

;; Raccourcis
(eval-after-load "dired"
  '(define-key dired-mode-map (kbd "<C-return>") 'jc-dired-open-file)
  )
(eval-after-load "dired"
  '(define-key dired-mode-map (kbd "<f1> o") 'jc-dired-find-file-latex))
(define-key dired-mode-map (kbd "C-c C-s") 'dired-toggle-sudo)

(defun jc-ido-dired-mode-hook ()
  (define-key dired-mode-map "$" 'jc-ido-bookmark-jump)
  (define-key dired-mode-map "," 'dired-hide-subdir)
  (define-key dired-mode-map "\M-," 'dired-hide-all))
