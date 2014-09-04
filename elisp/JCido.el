;; ~/emacs.d/JCido.el -*- mode: lisp-*-
(require 'ido)
(require 'bookmark)

(setq ido-enable-flex-matching t)
(ido-everywhere)
(ido-mode 1)
(setq ido-use-filename-at-point 'guess)
(setq ido-file-extensions-order '(".org" ".tex" ".emacs" ".el"))
(eval-after-load "tramp"
  '(add-to-list 'ido-work-directory-list-ignore-regexps tramp-file-name-regexp))

(defun jc-ido-bookmark-jump ()
  "Jump to bookmark using ido"
  (interactive)
  (let ((dir (jc-ido-get-bookmark-dir)))
    (when dir
      (find-alternate-file dir))))

(defun jc-ido-get-bookmark-dir ()
  "Get the directory of a bookmark."
  (let* ((name (ido-completing-read "Use dir of bookmark: " (bookmark-all-names) nil t))
         (bmk (bookmark-get-bookmark name)))
    (when bmk
      (setq bookmark-alist (delete bmk bookmark-alist))
      (push bmk bookmark-alist)
      (let ((filename (bookmark-get-filename bmk)))
        (if (file-directory-p filename)
            filename
          (file-name-directory filename))))))

(defun jc-ido-use-bookmark-dir ()
  "Get directory of bookmark"
  (interactive)
  (let* ((enable-recursive-minibuffers t)
         (dir (jc-ido-get-bookmark-dir)))
    (when dir
      (ido-set-current-directory dir)
      (setq ido-exit 'refresh)
      (exit-minibuffer))))

(defadvice ido-find-file (after find-file-sudo activate)
  "Find file as root if necessary."
  (unless (and buffer-file-name
               (file-writable-p buffer-file-name))
    (find-alternate-file (concat "/sudo::" buffer-file-name))))


(defun root-file-warning () 
  (when (string-match "^/su\\(do\\)?:" default-directory) 
    (face-remap-add-relative 
     'mode-line 
     '(:background "red3" :foreground "white")) 
    (face-remap-add-relative 
     'mode-line-inactive 
     '(:background "red4" :foreground "dark gray")) 
  ))
(add-hook 'find-file-hook 'root-file-warning)
(add-hook 'dired-mode-hook 'root-file-warning)

;; pour utiliser ido aussi pour dired copy/rename
(put 'dired-do-rename 'ido 'find-file)
(put 'dired-do-copy 'ido 'find-file)

;; Raccourcis
(add-hook 'ido-setup-hook 'ido-jc-keys)

(defun ido-jc-keys ()
 "Add my keybindings for ido."
 (define-key ido-completion-map (kbd "$") 'jc-ido-use-bookmark-dir)
 )
(define-key ido-file-dir-completion-map (kbd "$") 'jc-ido-use-bookmark-dir)
