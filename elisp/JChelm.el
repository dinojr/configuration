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

(setq linum-relative-with-helm t)
(helm-linum-relative-mode 1)






