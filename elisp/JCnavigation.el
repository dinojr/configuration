;; ~/.emacs.d/JCnavigation.el

;; la commande suivante permet de revenir à la marque sans activer la région
(defun exchange-point-and-mark-no-activate ()
  "Identical to \\[exchange-point-and-mark] but will not activate the region."
  (interactive)
  (exchange-point-and-mark)
  (deactivate-mark nil))
(define-key global-map [remap exchange-point-and-mark] 'exchange-point-and-mark-no-activate)

(defun unfill-paragraph ()
  "Takes a multi-line paragraph and makes it into a single line of text."
  (interactive)
  (let ((fill-column (point-max)))
    (fill-paragraph nil)))

(defun jc-indent-and-insert-tab ()
  (interactive)
  (beginning-of-line-text)
  (delete-horizontal-space)
  (indent-according-to-mode)
  (insert-tab)
  )

(defun jc-newline-and-indent (&optional arg)
  (interactive "*P")
  (delete-horizontal-space)
  (newline)
  (indent-according-to-mode)
  (if arg
      (insert-tab) ()
      ))

(setq search-invisible t)

(require 'printing)

;; --------------------------------------------------------------------
;; Redefine the Home/End keys to (nearly) the same as visual studio behaviour
;; special home and end by Shan-leung Maverick WOO
;; ------------------------------------------------------------------


(defun My-smart-home ()
  "Odd home to beginning of line, even home to beginning of text/code."
  (interactive)
  (if (and (eq last-command 'My-smart-home)
	   (/= (line-beginning-position) (point)))
      (beginning-of-line)
    (beginning-of-line-text))
  )
(defun My-smart-end ()
  "Odd end to end of line, even end to begin of text/code."
  (interactive)
  (if (and (eq last-command 'My-smart-end)
	   (= (line-end-position) (point)))
      (end-of-line-text)
    (end-of-line))
  )

(defun end-of-line-text ()
  "Move to end of current line and skip comments and trailing space."
  (interactive)
  (end-of-line)
  (let ((bol (line-beginning-position)))
    (unless (eq font-lock-comment-face (get-text-property bol 'face))
      (while (and (/= bol (point))
                  (eq font-lock-comment-face
                      (get-text-property (point) 'face)))
        (backward-char 1))
      (unless (= (point) bol)
        (forward-char 1) (skip-chars-backward " \t\n")))))

(if (fboundp 'tool-bar-mode)
    (tool-bar-mode -1))

; pour garder la mémoire d'où on en est :
(require 'saveplace)
(setq-default save-place t)
(setq save-place-file "~/.emacs.d/saved-places")
(setq server-visit-hook (quote (save-place-find-file-hook)))

;(add-hook 'text-mode-hook 'turn-on-auto-fill)

;; Affichage de l'heure
(setq display-time-day-and-date 1)
(setq display-time-24hr-format 1)
(display-time)

;; Coding system
(prefer-coding-system 'utf-8)
(set-charset-priority 'unicode)
(setq default-process-coding-system '(utf-8-unix . utf-8-unix))

;; Ace jump
(require 'ace-jump-mode)

;; expand-region
(add-to-list 'load-path "/home/wilk/info/emacs/expand-region.el")
(require 'expand-region)

;; Raccourcis
(global-set-key "\C-a" 'My-smart-home)
(global-set-key "\C-e" 'My-smart-end)
(define-key global-map "\M-Q" 'unfill-paragraph)
(define-key global-map (kbd "C-c j") 'ace-jump-mode)
(global-set-key (kbd "C-=") 'er/expand-region)
