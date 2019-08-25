;;~/.emacs.d/JChelm.el -*- mode: emacs-lisp-*-

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
(define-key isearch-mode-map [remap isearch-occur] 'helm-occur-from-isearch)
(define-key isearch-mode-map (kbd "M-s O") 'helm-multi-occur-from-isearch)

(setq helm-follow-mode-persistent t)
;; (define-key global-map [remap isearch-forward] 'swiper-helm)
(global-set-key (kbd "M-x") 'helm-M-x)
(unless (boundp 'completion-in-region-function)
  (define-key lisp-interaction-mode-map [remap completion-at-point] 'helm-lisp-completion-at-point)
  (define-key emacs-lisp-mode-map       [remap completion-at-point] 'helm-lisp-completion-at-point))

(require 'popup)
(require 'helm-eshell)
(require 'helm-files)
(require 'helm-grep)
(require 'helm-org-rifle)
(setq helm-org-rifle-show-path t)

(setq helm-split-window-in-side-p           t ; open helm buffer inside current window, not occupy whole other window
      helm-move-to-line-cycle-in-source     t ; move to end or beginning of source when reaching top or bottom of source.
      helm-ff-search-library-in-sexp        t ; search for library in `require' and `declare-function' sexp.
      helm-scroll-amount                    8 ; scroll 8 lines other window using M-<next>/M-<prior>
      helm-ff-file-name-history-use-recentf t)

(helm-autoresize-mode t)

(setq helm-buffers-fuzzy-matching t
      helm-recentf-fuzzy-match    t)

(setq helm-org-format-outline-path t)

(setq helm-mini-default-sources '(helm-source-buffers-list helm-source-bookmarks helm-source-recentf helm-source-buffer-not-found))


;; (global-set-key (kbd "M-x") 'helm-M-x)


;; (global-set-key (kbd "C-x b") 'helm-mini)



;; (global-set-key (kbd "C-x C-f") 'helm-find-files)

;; (global-set-key (kbd "C-c h o") 'helm-occur)

(helm-linum-relative-mode 1)

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
             '("Find File in Ace window ‘C-c C-e'" . helm-file-ace-window)
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

(setq helm-grep-ag-command "rg --color=always --smart-case --no-heading --line-number %s %s %s")
