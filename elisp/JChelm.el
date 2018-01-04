;;~/.emacs.d/JChelm.el -*- mode: lisp-*-

;; must set before helm-config,  otherwise helm use default
;; prefix "C-x c", which is inconvenient because you can
;; accidentially pressed "C-x C-c"
(global-set-key (kbd "C-c h") 'helm-command-prefix)
(global-unset-key (kbd "C-x c"))

;; (package-initialize)
(require 'helm-config)
(helm-mode 1)
(define-key global-map [remap find-file] 'helm-find-files)
(define-key global-map [remap occur] 'helm-occur)
(define-key global-map [remap list-buffers] 'helm-buffers-list)
(define-key global-map [remap switch-to-buffer] 'helm-mini)
(define-key global-map [remap dabbrev-expand] 'helm-dabbrev)
(define-key global-map [remap bookmark-jump] 'helm-filtered-bookmarks)
(global-set-key (kbd "M-x") 'helm-M-x)
(unless (boundp 'completion-in-region-function)
  (define-key lisp-interaction-mode-map [remap completion-at-point] 'helm-lisp-completion-at-point)
  (define-key emacs-lisp-mode-map       [remap completion-at-point] 'helm-lisp-completion-at-point))

(require 'popup)
(require 'helm-eshell)
(require 'helm-files)
(require 'helm-grep)

(setq helm-split-window-in-side-p           t ; open helm buffer inside current window, not occupy whole other window
      helm-move-to-line-cycle-in-source     t ; move to end or beginning of source when reaching top or bottom of source.
      helm-ff-search-library-in-sexp        t ; search for library in `require' and `declare-function' sexp.
      helm-scroll-amount                    8 ; scroll 8 lines other window using M-<next>/M-<prior>
      helm-ff-file-name-history-use-recentf t)

(helm-autoresize-mode t)

(setq helm-buffers-fuzzy-matching t
      helm-recentf-fuzzy-match    t)

(setq helm-org-format-outline-path t)

;; (global-set-key (kbd "M-x") 'helm-M-x)


;; (global-set-key (kbd "C-x b") 'helm-mini)



;; (global-set-key (kbd "C-x C-f") 'helm-find-files)

;; (global-set-key (kbd "C-c h o") 'helm-occur)

;; (setq linum-relative-with-helm t)
;; (helm-linum-relative-mode 1)

(require 'ace-jump-helm-line)
(define-key helm-map (kbd "C-'") 'ace-jump-helm-line)
;; or if using key-chord-mode
;; (eval-after-load "helm"
;;  '(key-chord-define helm-map "jj" 'ace-jump-helm-line))
(setq ace-jump-helm-line-style 'pre)
(setq ace-jump-helm-line-background t)
(setq ace-jump-helm-line-default-action 'select)
(setq ace-jump-helm-line-select-key ?e) ;; this line is not needed
;; Set the move-only and persistent keys
(setq ace-jump-helm-line-move-only-key ?o)
(setq ace-jump-helm-line-persistent-key ?p)
;; enable idle execution for `helm-mini'
;; (ace-jump-helm-line-idle-exec-add 'helm-mini)
;; enable hints preview
(ace-jump-helm-line-autoshow-mode +1)
;; use `linum-mode' to show
(setq ace-jump-helm-line-autoshow-mode-use-linum t)

(require 'ace-window)

(defun helm-buffer-ace-window (buffer)
  "Use ‘ace-window’ to select a window to display BUFFER."
  (ace-select-window)
  (switch-to-buffer buffer))

(defun helm-buffer-run-ace-window ()
  (interactive)
  (with-helm-alive-p
    (helm-exit-and-execute-action 'helm-buffer-ace-window)))

(define-key helm-buffer-map (kbd "C-c C-e") #'helm-buffer-run-ace-window)

(add-to-list 'helm-type-buffer-actions
             '("Switch to buffer in Ace window ‘C-c C-e'" . helm-buffer-ace-window)
             :append)

(defun helm-file-ace-window (file)
  "Use ‘ace-window' to select a window to display FILE."
  (ace-select-window)
  (find-file file))

(add-to-list 'helm-find-files-actions
             '("Find File in Ace window" . helm-find-ace-window)
             :append)

(defun helm-file-run-ace-window ()
  (interactive)
  (with-helm-alive-p
    (helm-exit-and-execute-action 'helm-file-ace-window)))

;;; For `helm-find-files'
(define-key helm-find-files-map (kbd "C-c C-e") #'helm-file-run-ace-window)


(setq helm-org-show-filename t)

(helm-flx-mode +1)

(eval-after-load 'flycheck
  '(define-key flycheck-mode-map (kbd "C-c ! h") 'helm-flycheck))
