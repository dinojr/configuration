;; ~/.emacs.d/JCgnus.el -*- mode: emacs-lisp-*-

;; (setq load-path (cons (expand-file-name "/home/wilk/info/emacs/gnus/lisp") load-path))
;; (eval-after-load "info"
;;   '(progn
;;     (add-to-list 'Info-directory-list "~/info/emacs/gnus/texi/")
;;     )
;;   )

;; (add-to-list 'load-path "~/git-repositories/emacs/lisp/gnus")
(add-to-list 'load-path "~/git-repositories/gnus-bogofilter/")
(require 'gnus-bogofilter)

;; (use-package gnus-bogofilter
;;   :quelpa (gnus-bogofilter
;;            :fetcher github
;;            :repo "tlikonen/gnus-bogofilter"))


(require 'gnus)
;; (require 'gnus-load)

(setq gnus-directory "~/email/News/")
(setq nnml-directory "~/email/Local/")
(setq user-full-name "Julien Cubizolles")
(setq user-mail-address "j.cubizolles@free.fr")
(setq mail-default-reply-to user-mail-address)

(setq gnus-completion-styles '(orderless basic))

(add-hook 'gnus-message-setup-hook 'turn-on-auto-fill)


;; (eval-after-load 'gnus 
;;   (lambda ()
;;     (add-hook 'gnus-agent-plugged-hook 'jc-gnus-open-agentized-servers)
;;     ;; (add-hook 'gnus-agent-plugged-hook 'jc-nuke-newsletter-group)
;;     )
;;   )

;; (if
;;     (featurep 'async)
;;     (progn
;;       (setq message-send-mail-function 'async-smtpmail-send-it)
;;       (setq send-mail-function 'async-smtpmail-send-it)))

(add-hook 'gnus-summary-exit-hook 'gnus-summary-bubble-group)

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
  "Move the current article to some other group and mark it as read.
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

(defun message-goto-gcc ()
  "Move point to the Gcc header."
  (interactive)
  (push-mark)
  (message-position-on-field "Gcc" "Bcc" "Cc" "To"))



(defun jc-gnus-message (id)
  "Compose a new message.
Start Gnus if it's not already running.
Change message identity to ID with gnus-identities-change."
  (interactive
   (list (completing-read  "Identity: " (gnus-identities-list) nil 1 )))
  (if (or (not (fboundp 'gnus-alive-p))
          (not (gnus-alive-p)))
      (gnus))
  (gnus-group-mail)
  (gnus-identities-change id)
  )

(defun jc-gnus-article-header-value (header) 
  "Get the value of HEADER for the current article." 
  (with-current-buffer gnus-original-article-buffer 
    (gnus-fetch-field header) ))


(defun jc-process-sender (sender)
  (gnus-kill "From" sender '(gnus-summary-mark-as-processable 1) t) )

(defun jc-process-sender-at-point ()
  (interactive)
  (save-window-excursion          ; better way 
    (gnus-summary-select-article) ; to do this?
    (let ((sender (jc-gnus-article-header-value "From")))
      (jc-process-sender sender) )))

(defun jc-process-recipient (recipient)
  (gnus-kill "To" recipient '(gnus-summary-mark-as-processable 1) t) )

(defun jc-process-recipient-at-point ()
  (interactive)
  (save-window-excursion          ; better way 
    (gnus-summary-select-article) ; to do this?
    (let ((recipient (jc-gnus-article-header-value "To")))
      (jc-process-sender recipient) )))

(defun jc-change-smtp-server (server)
  (interactive "M")
  (cond  ((string-equal server "free")
	  (setq 
	   smtpmail-smtp-server "smtp.free.fr"
	   smtpmail-default-smtp-server "smtp.free.fr")
	  )
	 ((string-equal server "gmail")
	  (setq 
	   smtpmail-smtp-server "smtp.gmail.com"
	   smtpmail-default-smtp-server "smtp.gmail.com")
	   ))
  )

;; Cleanup all Gnus buffers on exit

(defun exit-gnus-on-exit ()
  (if (and (fboundp 'gnus-group-exit)
	   (gnus-alive-p))
      (with-current-buffer (get-buffer "*Group*")
	(let (gnus-interactive-exit)
	  (gnus-group-exit)))))

(add-hook 'kill-emacs-hook 'exit-gnus-on-exit)

;; (add-to-list 'load-path "~/info/emacs/gnus/lisp")
;; (use-package gnus-bogofilter
;;   :quelpa (gnus-bogofilter
;;            :fetcher github
;;            :repo "tlikonen/gnus-bogofilter"))
(add-to-list 'load-path "~/git-repositories/gnus-bogofilter/")
(require 'gnus-bogofilter)

(defun jc-gnus-summary-mark-ham ()
  "Mark current article as ham "
  (interactive)
  (bogofilter-register-ham)
  (gnus-summary-mark-article nil gnus-ham-mark)
  )


(defun jc-mark-my-unseen-articles ()
  (interactive)
  (save-excursion
    (let ((articles gnus-newsgroup-unseen))
      (while articles
	(gnus-summary-select-article (pop articles))
	(let ((sender (jc-gnus-article-header-value "From")))
	  (if (string-match gnus-ignored-from-addresses sender)
	      (gnus-summary-mark-as-dormant 1)))))))

;; (add-hook 'gnus-prepare-group-hook 'jc-mark-my-unseen-articles)

;; (add-hook 'gnus-select-group-hook
;;    	   (lambda ()
;;    	     (mapcar (lambda (header)
;;    		       (mail-header-set-subject
;;    			header
;;    			(gnus-simplify-subject
;;    			 (mail-header-subject header) 're-only)))
;;    		     gnus-newsgroup-headers)))

(defun jc-turn-off-backup ()
            (set (make-local-variable 'backup-inhibited) t))

(add-hook 'nnfolder-save-buffer-hook 'jc-turn-off-backup)

;; Fix for bug https://debbugs.gnu.org/cgi/bugreport.cgi?bug=25702
(with-eval-after-load 'message
  (setq message-bogus-system-names
        (regexp-opt '("lago" "touco"))))

;; Raccourcis
(global-set-key "\C-xm" 'jc-gnus-message)

(with-eval-after-load 'gnus-sum
  (define-key gnus-summary-mode-map (kbd "B a") 'jc-gnus-summary-copy-and-expire-article)
  (define-key gnus-summary-mode-map (kbd "B M") 'jc-gnus-summary-move-and-mark-read-article)
  (define-key gnus-summary-mode-map (kbd "M P A") 'jc-process-sender-at-point)
  (define-key gnus-summary-mode-map (kbd "C-$") 'jc-gnus-summary-mark-ham)
  (define-key gnus-summary-mode-map ":" 'bbdb-mua-edit-field-recipients)
  )

(setq gnus-posting-styles
      '((".*"
	 (address "j.cubizolles@free.fr")
	 (name "Julien Cubizolles")
	 (x-identity "personnel")
	 ("Gcc" "nnmaildir+Free:General")
	 (signature-file "~/configuration/dotfiles/signature-perso.txt"))
	((header "from" ".*@ac-paris.fr")
	 (address "julien.cubizolles@ac-paris.fr")
	 (signature-file "~/configuration/dotfiles/signature-pro.txt")
	 ("X-Message-SMTP-Method" "smtp smtpbyod.ac-paris.fr 587 jcubizolles")
	 ("Gcc" "nnmaildir+Academie:mpsi2-organisation")
	 (x-identity "professionnel")
	 )
	((header "from" ".*@monlycee.net")
	 (address "julien.cubizolles@monlycee.net")
	 (signature-file "~/configuration/dotfiles/signature-pro.txt")
	 ("X-Message-SMTP-Method" "smtp smtps.monlycee.net 465 julien.cubizolles")
	 ("Gcc" "nnmaildir+ENT:mpsi2-organisation")
	 (x-identity "ENT")
	 )
	((header "from" "reprollg")
	 (address "julien.cubizolles@ac-paris.fr")
	 (signature-file "~/configuration/dotfiles/signature-pro.txt")
	 ("X-Message-SMTP-Method" "smtp smtpbyod.ac-paris.fr 587 jcubizolles")
	 ("Gcc" "reprollg")
	 ("to" "reprollg@gmail.com")
	 ("Subject" "MPSI2 Physique Semaine")
	 (x-identity "reprollg")
	 (body "Bonjour,\nMerci d'imprimer le document ci-joint en :\n+ 49 exemplaires\n+ taille réelle\n+ agrafé\n+ recto\n\nCordialement,")
	 )))
;; Le défaut en premier
;; Trier selon qu'on répond à des news ou pas
;; une fonction pour changer message-citation-line-format et message-citation-line-function selon le posting style (français/anglais)
;; attacher un logo LLG en fichier attaché ?

(require 'gnus-identities)


;; Pour ne pas indenter les Topics par mégarde
(with-eval-after-load 'gnus-topic
  (define-key gnus-topic-mode-map [tab] nil)
  (define-key gnus-topic-mode-map "\C-i" nil))

(require 'message)
(with-eval-after-load 'message
      (define-key message-mode-map [C-tab] 'bbdb-complete-mail)
      (define-key message-mode-map "\C-c\C-f\C-g" 'message-goto-gcc)
      )

(setq mml-attach-file-at-the-end t)

;; (add-hook 'message-mode-hook
;; 	  (lambda ()
;; 	    (define-key message-mode-map [C-tab] 'bbdb-complete-mail)
;; 	    (define-key message-mode-map "\C-c\C-f\C-g" 'message-goto-gcc)
;; 	    )
;; 	  )

;; (add-hook 'gnus-summary-mode-hook
;; 	  (lambda ()
;; 	    (define-key gnus-summary-mode-map ":" 'bbdb-mua-edit-field-recipients)
;; 	    )
;; 	  )

;; message-mark-inserted-region
