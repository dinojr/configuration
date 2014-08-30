;; ~/.emacs.d/emacs_interactive.el
;;--------------------
;; Custom paths
;;--------------------

(add-to-list 'load-path "/home/wilk/.emacs.d/naquadah-theme")

(add-to-list 'load-path "/home/wilk/.emacs.d/dired-toggle-sudo/")

(add-to-list 'load-path "~/info/emacs/auctex")
(setq TeX-data-directory "~/info/emacs/auctex/")
(add-to-list 'load-path "~/info/emacs/auctex/")
(add-to-list 'load-path "~/info/emacs/auctex/preview/")
(add-to-list 'load-path "~/info/emacs/autopair-latex/")
(eval-after-load "info"
  '(progn
    (add-to-list 'Info-directory-list "~/info/emacs/auctex/doc/")
    (add-to-list 'Info-directory-list "~/info/emacs/bbdb/doc/")
    (add-to-list 'Info-directory-list "~/info/emacs/gnus/texi/")
    )
  )

(eval-after-load 'calc
  '(require 'calc-ext)
  )

(add-to-list 'load-path "/home/wilk/texmf/asymptote/")

(add-to-list 'load-path "/home/wilk/.emacs.d/mingus/")

;;--------------------
;; Custom paths end
;;--------------------

;;------------------------------
;; Fondamental
;;------------------------------

;; Transient-mark-mode
(setq transient-mark-mode t)
;; C-SPC C-SPC pour mettre la marque sans activer la région

;; Info directory
(require 'info)
(add-to-list 'Info-directory-list
             (expand-file-name "/usr/local/share/info/"))

;; la commande suivante permet de revenir à la marque sans activer la région
(defun exchange-point-and-mark-no-activate ()
  "Identical to \\[exchange-point-and-mark] but will not activate the region."
  (interactive)
  (exchange-point-and-mark)
  (deactivate-mark nil))
(define-key global-map [remap exchange-point-and-mark] 'exchange-point-and-mark-no-activate)

;; (defun sudo-find-file (file-name)
;;   "Like find file, but opens the file as root."
;;   (interactive "FSudo Find File: ")
;;   (let ((tramp-file-name (concat "/sudo::" (expand-file-name file-name))))
;;     (find-file tramp-file-name))
  ;; (set-background-color "red")
  ;; (set-foreground-color "black")
  ;; )
;; (when (= (user-uid) 0)
;;       (set-background-color "red")
;;       (set-foreground-color "black"))


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

(add-hook 'gnus-message-setup-hook 'turn-on-auto-fill)
;; (add-hook 'emacs-lisp-mode-hook 'turn-on-auto-fill)
(add-hook 'org-mode-hook 'turn-on-auto-fill)


 ;; Conflict with dired-async
;; (defun unfocused-ding-blink ()
;;   "Flash the screen when Emacs is focused, ring the bell (ding) if not."
;;   (setq ring-bell-function `(lambda ()
;; 			      (setq visible-bell (fsm-frame-x-active-window-p (selected-frame)))
;; 			      (ding)))
;;     ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;     ;; Frame-related functions ;;
;;     ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;     ; All from http://www.emacswiki.org/emacs-pt/rcircDbusNotification
;;     (require 'dbus)
;;     (defun fsm-x-active-window ()
;;       "Return the window ID of the current active window in X, as
;;   given by the _NET_ACTIVE_WINDOW of the root window set by the
;;   window-manager, or nil if not able to"
;;       (if (eq (window-system) 'x)
;;           (let ((x-active-window (x-window-property "_NET_ACTIVE_WINDOW" nil "WINDOW" 0 nil t)))
;;             (string-to-number (format "%x00%x" (car x-active-window) (cdr x-active-window)) 16))
;;         nil))
;;     (defun fsm-frame-outer-window-id (frame)
;;       "Return the frame outer-window-id property, or nil if FRAME not of the correct type"
;;       (if (framep frame)
;;           (string-to-number
;;            (frame-parameter frame 'outer-window-id))
;;         nil))
;;     (defun fsm-frame-x-active-window-p (frame)
;;       "Check if FRAME is is the X active windows
;;   Returns t if frame has focus or nil if"
;;       (if (framep frame)
;;           (progn
;;             (if (eq (fsm-frame-outer-window-id frame)
;;                     (fsm-x-active-window))
;;                 t
;;               nil))
;;         nil))
;;   )
;; (unfocused-ding-blink)

(setq search-invisible t)

(require 'printing)
;; (pr-update-menus)

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

(require 'win-switch)
(win-switch-setup-keys-ijkl "\C-xo")
(setq win-switch-idle-time 1.5)
;; Fondamental end ;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;--------------------
;; Printing
;;--------------------
(require 'printing)
(pr-update-menus)
;;--------------------
;; Printing end
;;--------------------

;;--------------------
;; Raccourcis
;;--------------------

(define-key key-translation-map (kbd "²") (kbd "\\"))

(global-set-key "\C-cw" 'browse-url)
(global-set-key "\C-ch" 'browse-url-at-point)
;; (global-set-key "\C-c\C-s\C-f" 'sudo-find-file)
(global-set-key "\C-cd" 'ispell-change-dictionary)
(global-set-key "\C-a" 'My-smart-home)
(global-set-key "\C-e" 'My-smart-end)
;; (global-set-key [f1] 'delete-other-windows)
;; (global-set-key [f2] 'split-window-vertically)
;; (global-set-key [f3] 'split-window-horizontally)



(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)

(define-key global-map "\C-cc" 'org-capture)
(global-set-key (kbd "C-c C-g") (lambda () (interactive) (org-clock-in '(4))))
(global-set-key (kbd "C-c C-h") 'org-clock-out)
(global-set-key "\C-cq" 'mingus-query)

(global-set-key [f2] 'calendar)

;; (global-set-key [f5] 'jc-switch-to-workgroup-org)
(global-set-key [f5] (lambda () (interactive) (jc-switch-to-workgroup "org")))
;(global-set-key [f6] 'jc-switch-to-workgroup-gnus)
(global-set-key [f6] (lambda () (interactive) (jc-switch-to-workgroup "gnus")))
;(global-set-key [f7] 'jc-switch-to-workgroup-latex)
(global-set-key [f7] (lambda () (interactive) (jc-switch-to-workgroup "latex")))
;(global-set-key [f8] 'jc-switch-to-workgroup-bitlbee)
(global-set-key [f8] (lambda () (interactive) (jc-switch-to-workgroup "bitlbee")))

(global-set-key [f9] 'jc-jump-to-org-agenda)
(global-set-key [f10] 'jc-jump-to-gnus)
(global-set-key [f11] 'jc-jump-to-mingus)
(global-set-key [f12] 'jc-jump-to-bitlbee)

(global-set-key "\C-cm" 'gnus-group-mail)
(define-key global-map "\M-Q" 'unfill-paragraph)

(add-hook 'help-mode-hook
    (lambda () (define-key help-mode-map "l" 'help-go-back)))

(add-hook 'LaTeX-mode-hook
	  (lambda () ;;(define-key LaTeX-mode-map (kbd  "<C-tab>")
	    ;;'indent-relative)
	    ;; (define-key LaTeX-mode-map (kbd  "<C-tab>") 'insert-tab)
	    (define-key LaTeX-mode-map (kbd  "<C-tab>") 'jc-indent-and-insert-tab)
	    (define-key LaTeX-mode-map (kbd  "<C-return>") 'jc-newline-and-indent)
	    (define-key LaTeX-mode-map (kbd  "<M-f7>") 'jc-revert-and-rubber)
))

(define-key gnus-summary-mode-map (kbd "B a")
  'jc-gnus-summary-copy-and-expire-article)

(define-key gnus-summary-mode-map (kbd "B M")
  'jc-gnus-summary-move-and-mark-read-article)

(eval-after-load "dired"
  '(define-key dired-mode-map (kbd "<C-return>") 'jc-dired-open-file)
)

(setq flyspell-use-meta-tab nil)

;;--------------------
;; Raccourcis end
;;--------------------


;;--------------------
;; Ace-jump
;;--------------------
(require 'ace-jump-mode)
(define-key global-map (kbd "C-c j") 'ace-jump-mode)
;;--------------------
;; Ace-jump end
;;--------------------

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Apparence ;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'naquadah-theme)
;; '(default (:background background :foreground aluminium-1))
;; '(org-level-1 (:bold t :foreground gradient-1 :height 1))
;; '(org-level-2 (:bold t :foreground gradient-2 :height 1))
;; '(org-level-3 (:bold t :foreground gradient-3 :height 1))
;; '(gnus-header-subject (:bold t :foreground plum-1 :height 1))

(set-face-attribute 'org-level-1 nil :height 1.0)
(set-face-attribute 'org-level-2 nil :height 1.0)
(set-face-attribute 'org-level-3 nil :height 1.0)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Apparence end ;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Parenthèses et al ;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'rainbow-delimiters)
(add-hook 'LaTeX-mode-hook 'rainbow-delimiters-mode)
(add-hook 'LaTeX-mode-hook 'TeX-global-PDF-mode)
(add-hook 'emacs-lisp-mode-hook 'rainbow-delimiters-mode)


; Pour ne pas rajouter d'espaces avec les parenthèses et autres en TeX
(defun wilk-space-for-delimiter (endp delimiter)
  (not (member major-mode '(latex-mode))))

;; (eval-after-load "paredit"
;;   '(add-to-list 'paredit-space-for-delimiter-predicates
;;                 'wilk-space-for-delimiter))

;; (require 'autopair)
;; (autopair-global-mode) ;; to enable in all buffers
;; (setq autopair-autowrap t)

;; ;; (add-hook 'LaTeX-mode-hook (setq autopair-mode t))
;; ;; (add-hook 'emacs-lisp-mode-hook (setq autopair-mode t))
;; ;; (add-hook 'org-mode-hook (setq autopair-mode t))

;; ;; Charger paredit *après* autopair pour qu'il prenne la main quand il le faut
;; (require 'paredit)

;; ;; Conflit avec yasnippet
;; ;; (autoload 'enable-paredit-mode "paredit"
;; ;;   "Turn on pseudo-structural editing of Lisp code."
;; ;;   t)

;; (add-hook 'LaTeX-mode-hook 'enable-paredit-mode)
;; (add-hook 'emacs-lisp-mode-hook 'enable-paredit-mode)
;; ;; (add-hook 'gnus-message-setup-hook 'enable-paredit-mode)
;; ;; (add-hook 'org-mode-hook 'enable-paredit-mode)


(require 'smartparens)
;; do not autoinsert ' pair if the point is preceeded by word.  This
;; will handle the situation when ' is used as a contraction symbol in
;; natural language.  Nil for second argument means to keep the
;; original definition of closing pair.
(sp-pair "'" nil :actions nil)

;; emacs is lisp hacking enviroment, so we set up some most common
;; lisp modes too
(sp-with-modes sp--lisp-modes
  ;; disable ', it's the quote character!
  (sp-local-pair "'" nil :actions nil)
  ;; also only use the pseudo-quote inside strings where it serve as
  ;; hyperlink.
  (sp-local-pair "`" "'" :when '(sp-in-string-p)))

;; NOTE: Normally, `sp-local-pair' accepts list of modes (or a single
;; mode) as a first argument.  The macro `sp-with-modes' adds this
;; automatically.  If you want to call sp-local-pair outside this
;; macro, you MUST supply the major mode argument.

(sp-with-modes '(
                 tex-mode
                 plain-tex-mode
                 latex-mode
		 org-mode
                 )
  ;; math modes, yay.  The :actions are provided automatically if
  ;; these pairs do not have global definition.
  ;; (sp-local-pair "$" "$")
  (sp-local-pair "\\[" "\\]")
  (sp-local-pair "\\left(" "\\right)")
  (sp-local-pair "\\left{" "\\right}")
  (sp-local-pair "\\left[" "\\right]")
  (sp-local-pair "\\]" "\\[")
  ;; (sp-local-tag "\\b" "\\begin{_}" "\\end{_}")
  (sp-local-tag "$" "\\(" "\\)")
  )

(sp-use-paredit-bindings)
(smartparens-global-mode)

;; Parenthèses et al end ;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;--------------------
;; expand-region
;;--------------------

(add-to-list 'load-path "/home/wilk/info/emacs/expand-region.el")
(require 'expand-region)
(global-set-key (kbd "C-=") 'er/expand-region)

;;------------------
;; expand-region end
;;--------------------


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Ispell et al ;;;;;;;;;;;;;;;;;;;;;;;;;
(setq ispell-program-name "aspell")
(setq ispell-list-command "list")
(add-hook 'text-mode-hook
	  (lambda () (ispell-change-dictionary "francais"))
	  )
(setq ispell-tex-skip-alists
      (list
       (append (car ispell-tex-skip-alists)
               '(("\\\\cite"            ispell-tex-arg-end)
                 ("\\\\nocite"          ispell-tex-arg-end)
                 ("\\\\includegraphics" ispell-tex-arg-end)
                 ("\\\\figScale"         ispell-tex-arg-end)
                 ("\\\\author"          ispell-tex-arg-end)
                 ("\\\\ref"             ispell-tex-arg-end)
                 ("\\\\eqref"             ispell-tex-arg-end)
                 ("\\\\label"           ispell-tex-arg-end)
                 ))
       (cadr ispell-tex-skip-alists)))
(setq ispell-extra-args '("--sug-mode=ultra"))
; Empèche Ispell de vérifier le contenu des citation natbib
(eval-after-load "ispell"
  '(let ((list (car ispell-tex-skip-alists)))
     (add-to-list 'list '("\\\\cite[tp]" ispell-tex-arg-end))
     (setcar ispell-tex-skip-alists list)))

(require 'flyspell-lazy)
(flyspell-lazy-mode 1)

(defun jc-flyspell-check-next-highlighted-word ()
  "Custom function to spell check next highlighted word"
  (interactive)
  (flyspell-goto-next-error)
  (ispell-word)
  )
(global-set-key (kbd "M-<f8>") 'jc-flyspell-check-next-highlighted-word)

;; Ispell et al end ;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Dired ;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'dired)
(when (require 'dired-aux)
 (require 'dired-async))
;; (require 'dired-x)
;; (eval-after-load "dired-aux"
;;    '(add-to-list 'dired-compress-file-suffixes 
;;                  '("\\.zip\\'" ".zip" "unzip")))

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
(define-key dired-mode-map (kbd "C-c C-s") 'dired-toggle-sudo)
(eval-after-load 'tramp
 '(progn
    ;; Allow to use: /sudo:user@host:/path/to/file
    (add-to-list 'tramp-default-proxies-alist
		  '(".*" "\\`.+\\'" "/ssh:%h:"))))

(defun jc-dired-find-file-latex ()
  "In Dired, visit this file or directory and switch to workgroup latex"
  (interactive)
  (let 
      ((file (dired-get-file-for-visit)))
    (jc-switch-to-workgroup "latex")
    (find-file file)
    )
  )
(eval-after-load "dired"
  '(define-key dired-mode-map (kbd "<f1> o") 'jc-dired-find-file-latex))

(require 'bookmark)
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

(defun jc-ido-dired-mode-hook ()
  (define-key dired-mode-map "$" 'jc-ido-bookmark-jump)
  (define-key dired-mode-map "," 'dired-hide-subdir)
  (define-key dired-mode-map "\M-," 'dired-hide-all))

(add-hook 'dired-mode-hook 'jc-ido-dired-mode-hook)

(defun jc-dired-open-file ()
  "In dired, open the file named on this line."
  (interactive)
  (let* ((file (dired-get-filename nil t)))
    (message "Opening %s..." file)
    (call-process "gnome-open" nil 0 nil file)
    (message "Opening %s done" file)))

(add-hook 'dired-mode-hook 'dired-hide-details-mode)

;; Dired end ;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Ido ;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'ido)
(setq ido-enable-flex-matching t)
(ido-everywhere)
(ido-mode 1)
(setq ido-use-filename-at-point 'guess)
(setq ido-file-extensions-order '(".org" ".tex" ".emacs" ".el"))
(eval-after-load "tramp"
  '(add-to-list 'ido-work-directory-list-ignore-regexps tramp-file-name-regexp))

(require 'bookmark)
(defun jc-ido-use-bookmark-dir ()
  "Get directory of bookmark"
  (interactive)
  (let* ((enable-recursive-minibuffers t)
         (dir (jc-ido-get-bookmark-dir)))
    (when dir
      (ido-set-current-directory dir)
      (setq ido-exit 'refresh)
      (exit-minibuffer))))

(add-hook 'ido-setup-hook 'ido-jc-keys)

(defun ido-jc-keys ()
 "Add my keybindings for ido."
 (define-key ido-completion-map (kbd "$") 'jc-ido-use-bookmark-dir)
 )

(define-key ido-file-dir-completion-map (kbd "$") 'jc-ido-use-bookmark-dir)

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

;; Ido end ;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; WWW ;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'eww)
;; (require 'w3m)
;; (require 'w3m-load)
 (setq browse-url-browser-function 'browse-url-generic
       browse-url-generic-program "epiphany-browser")

(defun choose-browser (url &rest args)
  (interactive "sURL: ")
  (if (y-or-n-p "Use external browser? ")
      (browse-url-generic url)
    (eww-browse-url url)))

(setq browse-url-browser-function 'choose-browser)

;; (setq w3m-use-cookies t)
;; WWW end ;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; LaTeX ;;;;;;;;;;;;;;;;;;;;;;;;;

(defun jc-revert-and-rubber ()
  (interactive)
  (revert-buffer nil 1)
  (TeX-command "rubber" 'TeX-master-file 0)
  )
(setq TeX-clean-confirm nil)
(setq TeX-auto-save t)
(setq TeX-parse-self t)
(setq-default TeX-master nil)
(add-hook 'LaTeX-mode-hook
  (function
    (lambda ()
      (add-hook 'kill-buffer-hook 'TeX-clean nil t)
      ;gestion de la table matière et autre...
      (reftex-mode 1)
      ;; Corrrection à la volée syntaxique
      (flyspell-mode 1)
      ;; (setq speck-filter-mode 'TeX)
      ;; (speck-mode 1)
      ;; dictionnaire évitant les erreurs d'accents
      (ispell-change-dictionary "francais")
      ;; retour chariot	
      ;; (turn-on-auto-fill)
      (TeX-fold-mode 1)
      (TeX-PDF-mode)
      ;; preview-mode
;      (preview-mode 0)
      ;; crochets automatiques pour exposants et indices
      (setq TeX-electric-sub-and-superscript t)
)))

(setq LaTeX-section-hook
      '(LaTeX-section-title
	LaTeX-section-section
	LaTeX-section-label))

(setq TeX-view-format "pdf")

;; Pour avoir une fontification correcte

;;rubber comme compilateur
(add-hook 'LaTeX-mode-hook (lambda()
  (setq TeX-command-default "rubber")
  (add-to-list 'LaTeX-indent-environment-list '("code") )
  (add-to-list 'LaTeX-indent-environment-list '("tikzpicture"))
  (add-to-list 'LaTeX-indent-environment-list '("pspicture"))
  (add-to-list 'LaTeX-indent-environment-list '("equation*"))
  (add-to-list 'LaTeX-indent-environment-list '("equation") )
  (add-to-list 'LaTeX-indent-environment-list '("align") )
  (add-to-list 'LaTeX-indent-environment-list '("align*") )
  (add-to-list 'LaTeX-indent-environment-list '("table") )
  (add-to-list 'LaTeX-indent-environment-list '("tabular") )
  (add-to-list 'LaTeX-indent-environment-list '("pspicture") )
  (add-to-list 'LaTeX-indent-environment-list '("tikzpicture") )
  (add-to-list 'LaTeX-indent-environment-list '("axis") )
  (add-to-list 'LaTeX-indent-environment-list '("psgraph") )
  (add-to-list 'LaTeX-indent-environment-list '("maple") )
  (add-to-list 'LaTeX-indent-environment-list '("figure") )
  (add-to-list 'LaTeX-indent-environment-list '("scope") )
))


;; (defvar jc-LaTeX-no-autofill-environments
;;   '("equation" "equation*" "tikzpicture" "maple" "tabular" "align" "align*" "code")
;;   "A list of LaTeX environment names in which `auto-fill-mode' should be inhibited.")

;; (defun jc-LaTeX-auto-fill-function ()
;;   "This function checks whether point is currently inside one of
;; the LaTeX environments listed in
;; `jc-LaTeX-no-autofill-environments'. If so, it inhibits automatic
;; filling of the current paragraph."
;;   (let ((do-auto-fill t)
;;         (current-environment "")
;;         (level 0))
;;     (while (and do-auto-fill (not (string= current-environment "document")))
;;       (setq level (1+ level)
;;             current-environment (LaTeX-current-environment level)
;;             do-auto-fill (not (member current-environment jc-LaTeX-no-autofill-environments))))
;;     (when do-auto-fill
;;       (do-auto-fill))))

;; (defun jc-LaTeX-setup-auto-fill ()
;;   "This function turns on auto-fill-mode and sets the function
;; used to fill a paragraph to `jc-LaTeX-auto-fill-function'."
;;   (auto-fill-mode)
;;   (setq auto-fill-function 'jc-LaTeX-auto-fill-function))

;; (add-hook 'LaTeX-mode-hook 'jc-LaTeX-setup-auto-fill)


;; LaTeX end ;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;--------------------
;; RefTex
;;--------------------

(setq reftex-auto-recenter-toc t)
(setq reftex-toc-follow-mode nil)
(setq reftex-toc-include-labels t)
(setq reftex-toc-split-windows-fraction 0.3)
;; (setq reftex-label-regexps '("\\\\label{\\(?1:[^}]*\\)}" "\\[[^]]*\\<\\(meta\\)?label[[:space:]]*=[[:space:]]*{?\\(?1:[^],}]+\\)}?"))
;; (setq reftex-label-regexps '("\\\\label{\\(?1:[^}]*\\)}"
;; "\\[[^]]*\\<label[[:space:]]*=[[:space:]]*{?\\(?1:[^],}]+\\)}?"))

;; Pour utiliser d'autres mots-clefs que label
(eval-after-load 'reftex
  '(progn (add-to-list 'reftex-label-regexps
		 "\\[[^]]*\\<metalabel[[:space:]]*=[[:space:]]*{?\\(?1:[^],}]+\\)}?")
	 (reftex-compile-variables))
  )

;; Permet d'ignorer les occurences de label dans le code tikz
 (eval-after-load 'reftex
  '(progn (setq reftex-label-ignored-macros-and-environments '("tikzpicture" "pspicture" "pgfonlayer" "axis" "scope")))
  )

;; Je m'occupe de nommer mes labels
(eval-after-load 'reftex
  '(progn (setq reftex-insert-label-flags '("sft" t)))
  )
;; (reftex-compile-variables)

;; (add-to-list 'reftex-label-regexps
;; 	       "\\[[^]]*\\<metalabel[[:space:]]*=[[:space:]]*{?\\(?1:[^],}]+\\)}?")
;; (reftex-compile-variables)

;;--------------------
;; RefTex end
;;--------------------

;;--------------------
;; AucTeX
;;--------------------
(require 'dbus)
;; sans elpa
;; (load "auctex.el" nil t t)
;; (load "preview-latex.el" nil t t)

;; avec elpa
(require 'tex)
;; (require 'preview)

(setq TeX-fold-env-spec-list '(("[comment]" ("comment"))
			       ("[tikzpicture]" ("tikzpicture"))
			       ("[exercice]" ("exercice"))
			       ("[correction]" ("correction"))
			       ("[exoGuide]" ("exoGuide"))
			       ("[exoApp]" ("exoApp"))))

(eval-after-load "tex-fold" '(add-hook 'find-file-hook 'TeX-fold-buffer t))

(setq TeX-source-correlate-mode t)
(setq TeX-source-correlate-method 'synctex)
;; Pour remplacer le evince avec synctex qui ne se lance pas...
(eval-after-load "latex"
  '(progn
    (add-to-list 'TeX-view-program-list
			  '("jcEvince" ("evince" " %o")))
    (add-to-list 'TeX-view-program-selection
		 '(output-pdf "jcEvince"))
    (customize-set-variable 'LaTeX-math-abbrev-prefix (kbd "ù"))
    ;; (require 'autopair-latex)
    (add-hook 'org-mode-hook 'LaTeX-math-mode)
    (setq TeX-insert-braces nil)
    ))

(add-hook 'LaTeX-mode-hook 'LaTeX-math-mode)

(add-hook 'LaTeX-mode-hook
     	  (lambda () (set (make-variable-buffer-local 'TeX-electric-math)
     			  (cons "\\(" "\\)"))))
;; (define-key key-translation-map [?²] [?\] )


;;--------------------
;; AucTeX end
;;--------------------

;;--------------------
;; AucTeX tikz
;;--------------------
;; (add-to-list 'load-path "/home/wilk/info/emacs/auc-tikz/")
;; (load-file "/home/wilk/info/emacs/auc-tikz/auc-tikz-struct.el")
(add-to-list 'auto-mode-alist '( "\\.tikz\\'" . tex-mode))
;;--------------------
;; AucTeX tikz end
;;--------------------

;;--------------------
;; Asymptote
;;--------------------
(autoload 'asy-mode "asy-mode.el" "Asymptote major mode." t)
(autoload 'lasy-mode "asy-mode.el" "hybrid Asymptote/Latex major mode." t)
(autoload 'asy-insinuate-latex "asy-mode.el" "Asymptote insinuate LaTeX." t)
(add-to-list 'auto-mode-alist '("\\.asy" . asy-mode))
(add-to-list 'Info-directory-list
             (expand-file-name "/home/wilk/texmf/doc/info/"))
;;--------------------
;; Asymptote end
;;--------------------


;;--------------------
;; Ediff
;;--------------------
(setq ediff-merge-split-window-function 'split-window-vertically)
;;--------------------
;; Ediff end
;;--------------------

;;--------------------
;; tabbar
;;-------------------
(require 'tabbar)
(tabbar-mode 1)
(set-face-attribute
 'tabbar-default nil :background "gray10" :box nil
 :height 100
 ;:foundry "bitstream" :family "Bitstream Vera Sans"
)
(set-face-attribute
 'tabbar-unselected nil :background "gray10" :foreground "gray50" :box nil
)
(set-face-attribute
 'tabbar-selected nil :background "gray30" :foreground "white" :box nil
)
(set-face-attribute
 'tabbar-button nil :box nil :foreground "white"
)
(set-face-attribute
 'tabbar-separator nil :height 0.7
)
(setq tabbar-use-images nil) 
;;-------------------
;; tabbar: end
;;--------------------

;;--------------------
;; Workgroups
;;--------------------
(require 'workgroups)
(setq wg-morph-on nil)

;; (setq wg-morph-vsteps 3)
;; (setq wg-morph-hsteps 3)

;; C-c w est le standard, mais déjà utilisé pour browse-url
(setq wg-prefix-key [f1])

(workgroups-mode 1)
(if (not server-mode)
    (wg-load "/home/wilk/.emacs.d/workgroups.el")
  )


(defun jc-switch-to-workgroup (workgroup)
  (if (not (string= (wg-name (wg-current-workgroup 1))  workgroup)) 
      (wg-switch-to-workgroup (wg-get-workgroup 'name workgroup)))
)

;; (defun jc-switch-to-workgroup-org ()
;;   (interactive)
;;   (jc-switch-to-workgroup "org")
;; )

;; (defun jc-switch-to-workgroup-latex ()
;;   (interactive)
;;   (jc-switch-to-workgroup "latex")

;; )

;; (defun jc-switch-to-workgroup-gnus ()
;;   (interactive)
;;   (jc-switch-to-workgroup "gnus")
;; )

;; (defun jc-switch-to-workgroup-bitlbee ()
;;   (interactive)
;;   (jc-switch-to-workgroup "bitlbee")
;; )

;; (defun jc-switch-to-workgroup-mingus ()
;;   (interactive)
;;   (jc-switch-to-workgroup "mingus")
;; )

;(jc-switch-to-workgroup "latex")


;; (defun jc-switch-to-latex-workgroup ()
;;   (interactive)
;;   (if (not (string= (wg-name (wg-current-workgroup 1)) "latex")) 
;;     (wg-switch-to-workgroup (wg-get-workgroup 'name "latex")))
;;   )

;; (defun jc-switch-to-gnus-workgroup ()
;;   (interactive)
;;   (if (not (string= (wg-name (wg-current-workgroup 1)) "gnus")) 
;;     (wg-switch-to-workgroup (wg-get-workgroup 'name "gnus")))
;;   )

;; (defun jc-switch-to-org-workgroup ()
;;   (interactive)
;;   (if (not (string= (wg-name (wg-current-workgroup 1)) "org")) 
;;     (wg-switch-to-workgroup (wg-get-workgroup 'name "org")))
;;   )

;; (defun jc-switch-to-mingus-workgroup ()
;;   (interactive)
;;   (if (not (string= (wg-name (wg-current-workgroup 1)) "mingus")) 
;;     (wg-switch-to-workgroup (wg-get-workgroup 'name "mingus")))
;;   )

(defun jc-jump-to-org-agenda ()
  (interactive)
  ;; (if (not (string= (wg-name (wg-current-workgroup 1)) "org")) 
  ;;   (wg-switch-to-workgroup (wg-get-workgroup 'name "org")))
  (jc-switch-to-workgroup "org")
  (let ((buf (get-buffer "*Org Agenda*"))
        wind)
    (if buf
        (if (setq wind (get-buffer-window buf))
            (when (called-interactively-p 'any)
              (select-window wind)
              (org-fit-window-to-buffer))
          (if (called-interactively-p 'any)
              (progn
                (select-window (display-buffer buf t t))
                (org-fit-window-to-buffer))
            (with-selected-window (display-buffer buf)
              (org-fit-window-to-buffer))))
      (call-interactively 'org-agenda-list)
      ;; (org-agenda-redo)
      )))
;;--------------------
;; Workgroups end
;;--------------------


;;--------------------
;; Org interactif
;;--------------------
;; (require 'info)
;; (add-to-list 'Info-directory-list "")

(eval-after-load "info"
  '(add-to-list 'Info-directory-list "~/info/emacs/org-mode/doc/")
  )

(add-hook 'org-mode-hook 'flyspell-mode)
;(run-with-idle-timer 300 t ('jc-switch-to-org-workgroup 'jump-to-org-agenda))
;; (run-with-idle-timer 300 t 'jc-jump-to-org-agenda)
(setq org-insert-todo-heading-respect-content t)
(setq org-insert--heading-respect-content t)
(setq org-src-fontify-natively t)

(setq org-use-speed-commands t)

;; When set to a number in a list, try to get the width from any
;; #+ATTR.* keyword if it matches a width specification like
;;   #+ATTR_HTML: :width 300px
;; (setq org-image-actual-width '(300))


;; (customize-set-variable 'org-beamer-environments-extra '(("action" "k" "\\begin{actionenv}%a" "\\end{actionenv}")))
(setq org-beamer-environments-extra
      '(("action" "k" "\\begin{actionenv}%a" "\\end{actionenv}") 
	("only" "O" "\\begin{onlyenv}%a" "\\end{onlyenv}")
	("Definition" "D" "\\begin{DefiniTion}%a%U" "\\end{DefiniTion}")
	("Consequence" "S" "\\begin{Consequence}%a%U" "\\end{Consequence}")
	("Theoreme" "T" "\\begin{Theoreme}%a%U" "\\end{Theoreme}")
	("Exemple" "X" "\\begin{Exemple}%a" "\\end{Exemple}")))
(require 'notify)
(require 'filenotify)
(require 'org-mobile-sync)
(org-mobile-sync-mode 1)

;;--------------------
;; Org interactif end
;;--------------------

;;--------------------
;; Gnus interactif
;;--------------------
(eval-after-load 'gnus 
  (lambda ()
    (add-hook 'gnus-agent-plugged-hook 'jc-gnus-open-agentized-servers)
    ;; (add-hook 'gnus-agent-plugged-hook 'jc-nuke-newsletter-group)
    )
  )

(defun jc-jump-to-gnus ()
  (interactive)
  ;; (if (not (string= (wg-name (wg-current-workgroup 1)) "gnus")) 
  ;;   (wg-switch-to-workgroup (wg-get-workgroup 'name "gnus")))
  (jc-switch-to-workgroup "gnus")
  (let ((alist
         '(("\\`\\*unsent")
           ("\\`\\*Article")
           ("\\`\\*Summary")
           ("\\`\\*Group"
            (lambda (buf)
              (with-current-buffer buf
                (gnus-group-get-new-news))))))
        candidate)
    (catch 'found
      (dolist (item alist)
        (let ((regexp (nth 0 item))
              (test (nth 1 item))
              last)
          (dolist (buf (buffer-list))
            (if (string-match regexp (buffer-name buf))
                (setq last buf)))
          (if (and last (or (null test)
                            (funcall test last)))
              (throw 'found (setq candidate last))))))
    (if candidate
        (ido-visit-buffer candidate ido-default-buffer-method)
      (gnus-unplugged)
      ;; (gnus)
      )))
;(add-hook 'gnus-startup-hook 'gnus-namazu-update-all-indices)

(defun jc-gnus-summary-copy-and-expire-article (&optional n to-newsgroup select-method)
  "Copy the current article to some other group and mark it as expirable.
If TO-NEWSGROUP is string, do not prompt for a newsgroup to copy to.
When called interactively, if TO-NEWSGROUP is nil, use the value of
the variable `gnus-move-split-methods' for finding a default target."
  (interactive "P")
  (let ((articles (gnus-summary-work-articles n))
	article)
    (gnus-summary-move-article n to-newsgroup select-method 'copy)
    (save-excursion
      (while articles
    	(gnus-summary-goto-subject (setq article (pop articles)))
    	(let (gnus-newsgroup-processable)
    	  (command-execute 'gnus-summary-mark-as-expirable))
    	(gnus-summary-remove-process-mark article)))
    )
  )

(defun jc-gnus-summary-move-and-mark-read-article (&optional n to-newsgroup select-method)
  "Copy the current article to some other group and mark it as expirable.
If TO-NEWSGROUP is string, do not prompt for a newsgroup to copy to.
When called interactively, if TO-NEWSGROUP is nil, use the value of
the variable `gnus-move-split-methods' for finding a default target."
  (interactive "P")
  (let ((articles (gnus-summary-work-articles n))
	  article)
    (save-excursion
      (while articles
    	(gnus-summary-goto-subject (setq article (pop articles)))
	(let (gnus-newsgroup-processable)
	  (command-execute 'gnus-summary-mark-as-read-forward article))
    	)
      )
    (gnus-summary-move-article n to-newsgroup select-method)
    (gnus-summary-remove-process-mark article)
    )
  )


;; (add-hook 'gnus-agent-plugged-hook 'gnus-server-open-all-servers)


;;--------------------
;; Gnus interactif end
;;--------------------

;;--------------------
;; YAS
;;--------------------

(require 'yasnippet) ;; not yasnippet-bundle
(yas-global-mode 1)
(setq yas-triggers-in-field t); Enable nested triggering of snippets
;; (setq yas/root-directory '("~/.emacs.d/snippets/" "~/.emacs.d/elpa/yasnippet-20130112.1823/snippets"))

;; (yas/load-directory "~/.emacs.d/snippets" "~/.emacs.d/elpa/yasnippet-0.8.0/snippets")
;(yas/load-directory yas/root-directory)
;; (setq cua-enable-cua-keys nil)
;; (cua-mode)
;; (setq yas-wrap-around-region "cua")
;;--------------------
;; YAS end
;;--------------------



;;--------------------
;; Google/ORG
;;--------------------
(require 'google-maps)
(require 'org-location-google-maps)
(require 'google-weather)
(require 'org-google-weather)

(setq org-agenda-menu-show-match nil
      org-agenda-menu-two-column t)

;;--------------------
;; Google/ORG end
;;--------------------


;;--------------------
;; Cal-fw
;;--------------------
;(add-to-list 'load-path "~/.emacs.d/emacs-calfw")
(require 'calfw)
(require 'calfw-org)
(require 'calfw-gcal)
(setq cfw:fchar-junction ?╋
      cfw:fchar-vertical-line ?┃
      cfw:fchar-horizontal-line ?━
      cfw:fchar-left-junction ?┣
      cfw:fchar-right-junction ?┫
      cfw:fchar-top-junction ?┯
      cfw:fchar-top-left-corner ?┏
      cfw:fchar-top-right-corner ?┓)
;;--------------------
;; Cal-fw end
;;--------------------

;;--------------------
;; Midnight
;;--------------------
;; (require 'midnight)
;; (midnight-delay-set 'midnight-delay "6:00am")
;; (add-hook 'midnight-hook 'wilk-gnus-namazu-update-all-indices)
;;--------------------
;; Midnight end
;;--------------------

;;--------------------
;; Mingus
;;--------------------
(require 'mingus)
(require 'mingus-stays-home)
(autoload 'mingus "mingus-stays-home" t nil)

(defun jc-jump-to-mingus ()
  (interactive)
  ;; (if (not (string= (wg-name (wg-current-workgroup 1)) "org")) 
  ;;   (wg-switch-to-workgroup (wg-get-workgroup 'name "org")))
  (jc-switch-to-workgroup "mingus")
  (mingus-query)
  )

;(global-set-key "\C-cq" 'mingus-query)

(setq mingus-stream-alist
 (quote (("france inter" . "http://mp3.live.tv-radio.com/franceinter/all/franceinterhautdebit.mp3"))
))

(setq mingus-stream-alist
 (quote (("somafm" . "http://voxsc1.somafm.com:8070")
	 ("franceinter" . "http://mp3.live.tv-radio.com/franceinter/all/franceinterhautdebit.mp3")
	 ("lemouv" . ""))))

(setq mingus-podcast-alist
  (quote (("canteloup" . "http://www.europe1.fr/podcasts/revue-de-presque.xml") 
	  ("collin" . "http://radiofrance-podcast.net/podcast09/rss_12053.xml")
	  ("morin" . "http://radiofrance-podcast.net/podcast09/rss_10906.xml")
	  ("tete au carre" . "http://radiofrance-podcast.net/podcast09/rss_10212.xml")
	  ("masque" . "http://radiofrance-podcast.net/podcast09/rss_14007.xml")
	  ("marque mailhot" . "http://www.rtl.fr/podcast/la-marque-du-mailhot.xml")
	  ("porte" . "http://www.rtl.fr/podcast/a-la-bonne-heure-didier-porte.xml")
	  ("mailhot" . "http://www.rtl.fr/podcast/a-la-bonne-heure-regis-mailhot.xml")))
)
;;--------------------
;; Mingus end
;;--------------------


;;--------------------
;; Git
;;--------------------
;; (add-to-list 'load-path "/home/wilk/.emacs.d/elpa/magit-20130123.1617")
;; La ligne suivante corrige un bug de déclaration
(setq magit-log-edit-confirm-cancellation t)
(require 'magit)

;; (add-to-list 'load-path "/home/wilk/.emacs.d/elpa/magithub-20121130.1740")
;; (require 'magithub)
;; (add-to-list 'load-path "/home/wilk/.emacs.d/elpa/magit-gh-pulls-0.3")
;; (require 'magit-gh-pulls) pb de dépendances avec  eieio-1.3, à réinstaller plus tard
;;--------------------
;; Git end
;;--------------------

;;--------------------
;; Erc, bitlbee
;;--------------------
(require 'erc)
(add-to-list 'erc-modules 'notifications)
;; (require 'smiley)
;; (add-to-list 'erc-modules 'smiley)


(defun i-wanna-be-social ()
  "Connect to IM networks using bitlbee."
  (interactive)
  (erc :server "localhost" :port 6667 :nick "wilk"))

(defun bitlbee-identify ()
  (when (and (string= "localhost" erc-session-server)
          (string= "&bitlbee" (buffer-name)))
    (erc-message "PRIVMSG" (format "%s identify wilk lkb13704"
                             (erc-default-target)
                             ;djcb-bitlbee-password
			     ))))
;(bitlbee-identify)

(add-hook 'erc-join-hook 'bitlbee-identify)
(defun jc-switch-to-bitlbee-workgroup ()
  (interactive)
  (if (not (string= (wg-name (wg-current-workgroup 1)) "bitlbee")) 
      (wg-switch-to-workgroup (wg-get-workgroup 'name "bitlbee"))
  )
  )

(defun jc-jump-to-bitlbee ()
  (interactive)
  (jc-switch-to-bitlbee-workgroup)
  (i-wanna-be-social)
  )

(defun mpd-erc-np ()
      (interactive)
      (erc-send-message
       (concat "Now Playing: "
	       (let* ((string (shell-command-to-string "mpc")))
		 (string-match "[^/]*$" string)
		 (match-string 0 string)))))
;;--------------------
;; Erc, bitlbee end
;;--------------------


;;--------------------
;; BBDB interactif
;;--------------------
(defun remove-field-value (field value)
  "From every record in the active bbdb database, remove the notes field whose
  name is in passed in variable"
  (message "Field: %s; Value: %s" field value)
  (mapcar
   (lambda (rec)
     (let ((val (bbdb-record-note rec field)))
       (if (string= value val)
	   (progn
	     (bbdb-record-set-note rec field nil)
	     (bbdb-change-record rec)
	     (bbdb-redisplay-record rec)))))
   (bbdb-records)))

(defun remove-field (field)
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

;(remove-field-value 'folder "default")

;(remove-field 'bbdb-id)
;;--------------------
;; BBDB interactif end
;;--------------------

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Divers ;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'tramp)
(require 'boxquote)
(require 'dbus)
(defun th-evince-sync (file linecol)
   (let ((buf (get-buffer file))
         (line (car linecol))
         (col (cadr linecol)))
     (if (null buf)
         (message "Sorry, %s is not opened..." file)
       (switch-to-buffer buf)
       (goto-line (car linecol))
       (unless (= col -1)
         (move-to-column col)))))

(when (and
       (eq window-system 'x)
       (fboundp 'dbus-register-signal))
  (dbus-register-signal
   :session nil "/org/gnome/evince/Window/0"
   "org.gnome.evince.Window" "SyncSource"
   'th-evince-sync))
;; Divers end ;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;--------------------
;; Regexps
;;--------------------
(defun jc-alert-or-emph-to-stars ()
  "Replace \\alert{toto} or \\emph{toto} by *toto*"
  (interactive)
  (query-replace-regexp "\\\\\\(alert\\|emph\\){\\(.+?\\)}" "*\\2*")
  )

(defun jc-item-to-plus ()
  "Replace \\item by +"
  (interactive)
  (query-replace-regexp "\\\\item" "+")
  )

(defun jc-block-to-heading ()
  "Replace \\begin{block}toto\\end{block} by toto"
  (interactive)
  (query-replace-regexp "\\\\begin{block}{\\(.*?\\)}\\([\\ \n\t [:nonascii:] [:ascii:]]*?\\)\\\\end{block}" "* \\1\n\\2")
  )

(defun jc-block-to-consequence ()
  "Replace \\begin{block}<something>{Titre}toto\\end{block} by \\begin{consequence}[Titre]toto\\end{consequence}"
  (interactive)
  (query-replace-regexp "\\\\begin{block}\\(<.*?>\\)?{\\(.*?\\)}\\([\\ \n\t [:nonascii:] [:ascii:]]*?\\)\\\\end{block}" "\\\\begin{consequence}\[\\2\]\\3\n\\\\end{consequence}")
  )

(defun jc-dollar-to-paren ()
  "Replace $toto$ by \\(toto\\)"
  (interactive)
  (query-replace-regexp "\\$\\([\n\t [:nonascii:] [:ascii:]]+?\\)\\$" "\\\\\(\\1\\\\\)")
  )

(defun jc-only-to-heading ()
  "Replace \\only<act>{toto} by 
     * Titre
       :PROPERTIES:
       :BEAMER_env: action
       :BEAMER_ACT: only@act
       :END:"
  (interactive)
  (query-replace-regexp "\\\\only<\\(.*?\\)>{\\([ \n \t [:ascii:] [:nonascii:]]*\\)}" "* \?\n\t:PROPERTIES:\n\t:BEAMER_env: action\n\t:BEAMER_ACT: only@\\1\n\t:END:\n\n\t\\2")
  )

(defun jc-do-all-regexps ()
  (interactive)
  (lambda ()
    (jc-alert-or-to-stars)
    (jc-dollar-to-paren)
    (jc-item-to-plus))
    )
(define-prefix-command 'jc-regexps)
(global-set-key (kbd "C-!") 'jc-regexps)
(define-key jc-regexps (kbd "a") 'jc-alert-or-emph-to-stars)
(define-key jc-regexps (kbd "d") 'jc-dollar-to-paren)
(define-key jc-regexps (kbd "b") 'jc-block-to-heading)
(define-key jc-regexps (kbd "o") 'jc-only-to-heading)
(define-key jc-regexps (kbd "i") 'jc-item-to-plus)

;;--------------------
;; Regexps end
;;--------------------


;;--------------------
;; SyncTeX
;;--------------------

;; ; SyncTeX basics

;; ; un-urlify and urlify-escape-only should be improved to handle all special characters, not only spaces.
;; ; The fix for spaces is based on the first comment on http://emacswiki.org/emacs/AUCTeX#toc20

;; (defun un-urlify (fname-or-url)
;;   "Transform file:///absolute/path from Gnome into /absolute/path with very limited support for special characters"
;;   (if (string= (substring fname-or-url 0 8) "file:///")
;;       (url-unhex-string (substring fname-or-url 7))
;;     fname-or-url))

;; (defun urlify-escape-only (path)
;;   "Handle special characters for urlify"
;;   (replace-regexp-in-string " " "%20" path))

;; (defun urlify (absolute-path)
;;   "Transform /absolute/path to file:///absolute/path for Gnome with very limited support for special characters"
;;   (if (string= (substring absolute-path 0 1) "/")
;;       (concat "file://" (urlify-escape-only absolute-path))
;;       absolute-path))

;; ; SyncTeX backward search - based on http://emacswiki.org/emacs/AUCTeX#toc20, reproduced on http://tex.stackexchange.com/a/49840/21017

;; (defun th-evince-sync (file linecol &rest ignored)
;;   (let* ((fname (un-urlify file))
;;          (buf (find-file fname))
;;          (line (car linecol))
;;          (col (cadr linecol)))
;;     (if (null buf)
;;         (message "[Synctex]: Could not open %s" fname)
;;       (switch-to-buffer buf)
;;       (goto-line (car linecol))
;;       (unless (= col -1)
;;         (move-to-column col)))))

;; (defvar *dbus-evince-signal* nil)

;; (defun enable-evince-sync ()
;;   (require 'dbus)
;;   ; cl is required for setf, taken from: http://lists.gnu.org/archive/html/emacs-orgmode/2009-11/msg01049.html
;;   (require 'cl)
;;   (when (and
;;          (eq window-system 'x)
;;          (fboundp 'dbus-register-signal))
;;     (unless *dbus-evince-signal*
;;       (setf *dbus-evince-signal*
;;             (dbus-register-signal
;;              :session nil "/org/gnome/evince/Window/0"
;;              "org.gnome.evince.Window" "SyncSource"
;;              'th-evince-sync)))))

;; (add-hook 'LaTeX-mode-hook 'enable-evince-sync)

;; ; SyncTeX forward search - based on http://tex.stackexchange.com/a/46157

;; ;; universal time, need by evince
;; (defun utime ()
;;   (let ((high (nth 0 (current-time)))
;;         (low (nth 1 (current-time))))
;;    (+ (* high (lsh 1 16) ) low)))

;; ;; Forward search.
;; ;; Adapted from http://dud.inf.tu-dresden.de/~ben/evince_synctex.tar.gz
;; (defun auctex-evince-forward-sync (pdffile texfile line)
;;   (let ((dbus-name
;;      (dbus-call-method :session
;;                "org.gnome.evince.Daemon"  ; service
;;                "/org/gnome/evince/Daemon" ; path
;;                "org.gnome.evince.Daemon"  ; interface
;;                "FindDocument"
;;                (urlify pdffile)
;;                t     ; Open a new window if the file is not opened.
;;                )))
;;     (dbus-call-method :session
;;           dbus-name
;;           "/org/gnome/evince/Window/0"
;;           "org.gnome.evince.Window"
;;           "SyncView"
;;           (urlify-escape-only texfile)
;;           (list :struct :int32 line :int32 1)
;;   (utime))))

;; (defun auctex-evince-view ()
;;   (let ((pdf (file-truename (concat default-directory
;;                     (TeX-master-file (TeX-output-extension)))))
;;     (tex (buffer-file-name))
;;     (line (line-number-at-pos)))
;;     (auctex-evince-forward-sync pdf tex line)))

;; ;; New view entry: Evince via D-bus.
;; (setq TeX-view-program-list '())
;; (add-to-list 'TeX-view-program-list
;;          '("EvinceDbus" auctex-evince-view))

;; ;; Prepend Evince via D-bus to program selection list
;; ;; overriding other settings for PDF viewing.
;; (setq TeX-view-program-selection '())
;; (add-to-list 'TeX-view-program-selection
;;          '(output-pdf "EvinceDbus"))

;;--------------------
;; SyncTeX end
;;--------------------


;; (jc-jump-to-org-agenda)
;; (delete-window)

;; (require 'dired-async)
