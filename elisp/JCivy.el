;;~/.emacs.d/JCivy.el -*- mode: lisp; lexical-binding: t -*-

(ivy-mode 1)
(setq ivy-use-virtual-buffers t)
(setq enable-recursive-minibuffers t)
(setq ivy-re-builders-alist '((swiper . ivy--regex-plus)
                (counsel-ag . ivy--regex-plus)
                (counsel-grep-or-swiper . ivy--regex-plus)
		(counsel-M-x . ivy--regex-plus)
                (t . ivy--regex-fuzzy)))

(global-set-key "\C-s" 'swiper)
(global-set-key (kbd "C-c C-r") 'ivy-resume)
(global-set-key (kbd "<f6>") 'ivy-resume)
(global-set-key (kbd "M-x") 'counsel-M-x)
(global-set-key (kbd "C-x C-f") 'counsel-find-file)
(global-set-key (kbd "<f1> f") 'counsel-describe-function)
(global-set-key (kbd "<f1> v") 'counsel-describe-variable)
(global-set-key (kbd "<f1> l") 'counsel-find-library)
(global-set-key (kbd "<f2> i") 'counsel-info-lookup-symbol)
(global-set-key (kbd "<f2> u") 'counsel-unicode-char)
(global-set-key (kbd "C-c g") 'counsel-git)
(global-set-key (kbd "C-c j") 'counsel-git-grep)
(global-set-key (kbd "C-c k") 'counsel-ag)
(global-set-key (kbd "C-x l") 'counsel-locate)
(global-set-key (kbd "C-S-o") 'counsel-rhythmbox)
(define-key minibuffer-local-map (kbd "C-r") 'counsel-minibuffer-history)

(defun reloading (cmd)
  (lambda (x)
    (funcall cmd x)
    (ivy--reset-state ivy-last)))
(defun given-file (cmd prompt) ; needs lexical-binding
  (lambda (source)
    (let ((target
           (let ((enable-recursive-minibuffers t))
             (read-file-name
              (format "%s %s to:" prompt source)))))
      (funcall cmd source target 1))))
(defun confirm-delete-file (x)
  (dired-delete-file x 'confirm-each-subdirectory))

(ivy-add-actions
 'counsel-find-file
 `(("c" ,(given-file #'copy-file "Copy") "copy")
   ("d" ,(reloading #'confirm-delete-file) "remove")
   ("m" ,(reloading (given-file #'rename-file "Move")) "move")))

;; (use-package ivy :ensure t
;;   :diminish ivy-mode
;;   :init (setq projectile-completion-system 'ivy)
;;   :bind
;;   (:map ivy-mode-map ("C-'" . ivy-avy))
;;   :config
;;   (ivy-mode 1)
;;   (setq ivy-use-virtual-buffers t)
;;   (setq ivy-height 13)
;;   (setq ivy-initial-inputs-alist nil)
;;   (setq ivy-count-format "%d/%d ")
;;   (setq ivy-virtual-abbreviate 'full) ; Show the full virtual file paths
;;   (setq ivy-extra-directories '("./")) ; default value: ("../" "./")
;;   (setq ivy-wrap t)
;;   (setq ivy-re-builders-alist '((swiper . ivy--regex-plus)
;;                 (counsel-ag . ivy--regex-plus)
;;                 (counsel-grep-or-swiper . ivy--regex-plus)
;;                 (t . ivy--regex-fuzzy))))
 
;; (use-package counsel-projectile :ensure t
;;   :bind* (("C-c p p" . counsel-projectile))
;;   :init
;;   (setq counsel-projectile-drop-to-switch-project-binding "C-c s p")
;;   (counsel-projectile-on))
 
;; (use-package counsel :ensure t
;;   :bind*
;;   (("M-x" . counsel-M-x)
;;    ("C-c d d" . counsel-descbinds)
;;    ("C-c s s" . counsel-ag)
;;    ("C-c s d" . counsel-ag-projectile)
;;    ("C-x C-f" . counsel-find-file)
;;    ("C-x r f" . counsel-recentf)
;;    ("C-c g g" . counsel-git)
;;    ("C-c g G" . counsel-git-grep)
;;    ("C-x l" . counsel-locate)
;;    ("C-c g s" . counsel-grep-or-swiper)
;;    ("C-M-y" . counsel-yank-pop)
;;    ("C-c C-r" . ivy-resume)
;;    ("C-c i m" . counsel-imenu)
;;    ("C-c i M" . ivy-imenu-anywhere)
;;    ("C-c d s" . describe-symbol)
;;    :map ivy-minibuffer-map
;;    ("M-y" . ivy-next-line-and-call))
 
;;   :config
;;   (defun reloading (cmd)
;;     (lambda (x)
;;       (funcall cmd x)
;;       (ivy--reset-state ivy-last)))
;;   (defun given-file (cmd prompt) ; needs lexical-binding
;;     (lambda (source)
;;       (let ((target
;;          (let ((enable-recursive-minibuffers t))
;;            (read-file-name
;;         (format "%s %s to:" prompt source)))))
;;     (funcall cmd source target 1))))
;;   (defun confirm-delete-file (x)
;;     (dired-delete-file x 'confirm-each-subdirectory))
 
;;   (ivy-add-actions
;;    'counsel-find-file
;;    `(("c" ,(given-file #'copy-file "Copy") "copy")
;;      ("d" ,(reloading #'confirm-delete-file) "delete")
;;      ("m" ,(reloading (given-file #'rename-file "Move")) "move")))
;;   (ivy-add-actions
;;    'counsel-projectile-find-file
;;    `(("c" ,(given-file #'copy-file "Copy") "copy")
;;      ("d" ,(reloading #'confirm-delete-file) "delete")
;;      ("m" ,(reloading (given-file #'rename-file "Move")) "move")
;;      ("b" counsel-find-file-cd-bookmark-action "cd bookmark")))
 
;;   ;; to make counsel-ag search the root projectile directory.
;;   (defun counsel-ag-projectile ()
;;     (interactive)
;;     (counsel-ag nil (projectile-project-root)))
 
;;   (setq counsel-find-file-at-point t)
;;   ;; ignore . files or temporary files
;;   (setq counsel-find-file-ignore-regexp
;;     (concat
;;      ;; File names beginning with # or .
;;      "\\(?:\\`[#.]\\)"
;;      ;; File names ending with # or ~
;;      "\\|\\(?:\\`.+?[#~]\\'\\)")))
