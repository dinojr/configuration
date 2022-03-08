;; ~/.gnus.el -*- mode: emacs-lisp-*-
(require 'gnus)
;; (require 'gnuslog)


(setq auth-source-debug t)
(setq debug-on-error t)
(setq imap-log t)

;; (if gnus-batch-mode (setq gnus-plugged t) (setq gnus-plugged nil)) ;; pour ramasser le courrier en batch
;; (setq gnus-plugged nil)
(setq gnus-agent-expire-all nil)
(setq gnus-agent-expire-days 30)
(add-hook 'gnus-exit-gnus-hook 'gnus-agent-expire)

; Pour ne pas utiliser le .newsrc : double emploi avec .newsrc.eld
(setq gnus-save-newsrc-file nil)
(setq gnus-read-newsrc-file nil)
(setq gnus-use-dribble-file t)
(setq gnus-always-read-dribble-file nil)

;; BBDB stuff
;; initialisé dans emacs_noninteractive
;; (require 'bbdb)
;; (bbdb-initialize 'gnus 'message 'w3)
;; (bbdb-initialize 'gnus 'message 'w3)
;; (add-hook 'gnus-startup-hook 'bbdb-insinuate-gnus)
;; (add-hook 'mail-setup-hook 'bbdb-insinuate-message)
;; (add-hook 'message-setup-hook 'bbdb-azliasinsinuate-message)

;Dired
(add-hook 'dired-mode-hook 'turn-on-gnus-dired-mode)
(add-hook 'message-mode-hook 'turn-on-gnus-dired-mode)

; À mettre dans cet ordre pour éviter un message d'erreur
(setq gnus-registry-install t)
(require 'gnus-registry)

;; (setq-default
;;  spam-log-to-registry t
;;  gnus-registry-max-entries 10000
;;  gnus-registry-track-extra nil
;;  gnus-refer-article-method '(current (nnregistry)))

;; (gnus-registry-initialize)



; Pour ne pas passer au message suivant avec SPACE
(setq gnus-summary-stop-at-end-of-message t)

;; Bug avec emacs-snapshot qui n'a plus make-local-hook, il suffit d'enlever l'appel à make-local-hook dans egocentric.el
;; (add-hook 'gnus-article-prepare-hook 'egocentric-mode-on nil t)

(add-hook 'gnus-group-mode-hook 'gnus-topic-mode)

;; (setq gnus-thread-sort-functions '((not gnus-thread-sort-by-date) (not gnus-thread-sort-by-most-recent-date)))
;; (setq gnus-thread-sort-functions
;;            '(gnus-thread-sort-by-date))

;; (setq gnus-thread-sort-functions '(gnus-thread-sort-by-number
;;                                    (not gnus-thread-sort-by-most-recent-date)))

(setq gnus-thread-sort-functions
      '(gnus-thread-sort-by-number
	gnus-thread-sort-by-most-recent-date))


(setq gnus-summary-thread-gathering-function 'gnus-gather-threads-by-references)

;; (load "~/.emacs.d/gnus-mst-addons/gnus-mst-common.elc")
;; (load "~/.emacs.d/gnus-mst-addons/gnus-mst-manipulate-threads.elc")


;; More logical ordering within thread:
;(setq gnus-sort-gathered-threads-function 'gnus-thread-sort-by-date)
;; Like Gmail:  bubble most recently active threads to the bottom:
;; (setq gnus-thread-sort-functions
;;       '(
;;         (not gnus-thread-sort-by-most-recent-date)
;;         ))

;; (add-to-list 'gnus-newsgroup-variables 'gnus-large-newsgroup)
;; (add-to-list 'gnus-newsgroup-variables 'gnus-fetch-old-headers)
;; (setq gnus-large-newsgroup 200)
;; (setq gnus-fetch-old-headers 'some)


(setq gnus-group-line-format "%M%S%p%P%5y|%2-i:%m%B%(%G%)%O\n")

(setq nnimap-authinfo-file "~/.authinfo")

;; (setq nnir-notmuch-remove-prefix (regexp-opt '("/home/wilk/email/Local/" "/home/wilk/email/Local/archive/" "/home/wilk/email/Maildir/Free" "/home/wilk/email/Maildir/Free"))) ;; ne marche pas
(setq nnir-notmuch-remove-prefix "/home/wilk/email/Local/") ;; marche
;; (setq gnus-search-notmuch-remove-prefix "/home/wilk/email/Local/")
;; (setq nnir-notmuch-remove-prefix "/home/wilk/email/Maildir/Free/") ;; ne marche pas

(setq gnus-select-method 
      '(nnml "Local"
	     (nnml-directory "~/email/Local")
	     (nnml-active-file "~/email/Local/active")
	     (nnml-get-new-mail nil)
	     (nnir-search-engine notmuch)
	     )
      )

; Pour ne pas télécharger les pièces jointes par défaut
;(setq nnimap-fetch-partial-articles "text/")
(setq nnimap-fetch-partial-articles nil)

(setq gnus-ignored-from-addresses (regexp-opt '("j.cubizolles@free.fr" "j.cubizolles@gmail.com" "julien.cubizolles@ac-paris.fr" "julien.cubizolles@monlycee.net")))

(setq bbdb/gnus-split-nomatch-function nil
      bbdb/gnus-split-default-group nil
      bbdb/gnus-split-myaddr-regexp gnus-ignored-from-addresses
      )

;; SPAM
(require 'spam)
(spam-initialize 'spam-use-move)
(setq spam-use-bogofilter t)

(setq spam-mark-ham-unread-before-move-from-spam-group t)
(setq spam-mark-only-unseen-as-spam nil)
;; (setq spam-autodetect-recheck-messages t)

(setq spam-split-group "Junk") ;unqualified group name
;; (setq spam-junk-mailgroups (quote ("nnml+local:junk" "nnimap+free:Junk" "nnimap+gmail:[Gmail]/Spam")))

;; (setq  nnmail-split-lowercase-expanded t)

;; Splitting

(setq gnus-secondary-select-methods
      '(
	;; 	(nnimap "gmail"
	;;                 (nnimap-address "imap.gmail.com")
	;; ;		(nnimap-authentificator "j.cubizolles")
	;; ;               (nnimap-authinfo-file "~/.authinfo")
	;;                 (nnimap-stream ssl)
	;; 		(nnir-search-engine imap)
	;; 		;; (nnimap-split-methods nnimap-split-fancy)
	;; 		(nnimap-inbox "INBOX")
	;; 		(nnimap-split-methods default)
	;; 		)
	;; 	(nnimap "free"
	;; 		(nnimap-address "imap.free.fr")
	;; 		; Ne marche pas sans la ligne suivante
	;; ;		(nnimap-authentificator "j.cubizolles")
	;; ;		(nnimap-authinfo-file "~/.authinfo")
	;; ;		(nnimap-unsplittable-articles (%Deleted %Seen))
	;; 		(nnir-search-engine imap)
	;; 		(nnimap-inbox "INBOX")
	;; 		;; (nnimap-split-methods nnimap-split-fancy)
	;; 		(nnimap-split-methods default)
	;; 		)
	(nntp "news.free.fr")
	(nntp "news.gwene.org"
	      (nnir-search-engine notmuch))
	(nntp "news.gmane.io"
	      (nnir-search-engine notmuch))
	;; (nnmaildir "FreeOffline" (directory "~/email/Maildir/Free/"))
	;; (nnimap "GmailOffline"
	;; 	(nnimap-stream shell)
	;; 	(nnimap-shell-program "/usr/lib/dovecot/imap -o mail_location=maildir:$HOME/Maildir-gmail")
	;; 	)
	(nnimap "FreeOffline"
		(nnimap-stream shell)
		;; (nnimap-shell-program "/usr/lib/dovecot/imap -c /home/wilk/.dovecotrc-free")
		(nnimap-shell-program "/usr/lib/dovecot/imap -o mail_location=maildir:$HOME/email/Maildir/Free:LAYOUT=fs")
		(nnimap-split-methods default)
		(nnimap-inbox "INBOX")
		;; (nnir-search-engine imap)
		(nnir-search-engine notmuch)
		;; (nnir-notmuch-remove-prefix "/home/wilk/email/Maildir/Free/")
		)
	(nnimap "GmailOffline"
		(nnimap-stream shell)
		;; (nnimap-shell-program "/usr/lib/dovecot/imap -c /home/wilk/.dovecotrc-gmail")
		(nnimap-shell-program "/usr/lib/dovecot/imap -o mail_location=maildir:$HOME/email/Maildir/Gmail:LAYOUT=fs")
		(nnimap-split-methods default)
		(nnimap-inbox "INBOX")
		;; (nnir-search-engine imap)
		(nnir-search-engine notmuch)
		;; (nnir-notmuch-remove-prefix "/home/wilk/email/Maildir/Gmail/")
		)
	(nnimap "ENT"
		(nnimap-stream shell)
		;; (nnimap-shell-program "/usr/lib/dovecot/imap -c /home/wilk/.dovecotrc-free")
		(nnimap-shell-program "/usr/lib/dovecot/imap -o mail_location=maildir:$HOME/email/Maildir/ENT:LAYOUT=fs")
		(nnimap-split-methods default)
		(nnimap-inbox "INBOX")
		;; (nnir-search-engine imap)
		(nnir-search-engine notmuch)
		;; (nnir-notmuch-remove-prefix "/home/wilk/email/Maildir/Free/")
		)
	(nnimap "Academie"
		(nnimap-stream shell)
		;; (nnimap-shell-program "/usr/lib/dovecot/imap -c /home/wilk/.dovecotrc-free")
		(nnimap-shell-program "/usr/lib/dovecot/imap -o mail_location=maildir:$HOME/email/Maildir/Academie:LAYOUT=fs")
		(nnimap-split-methods default)
		(nnimap-inbox "INBOX")
		;; (nnir-search-engine imap)
		(nnir-search-engine notmuch)
		;; (nnir-notmuch-remove-prefix "/home/wilk/email/Maildir/Free/")
		)		
	;; (nnnotmuch "")
	;; (nnfolder "archive"
	;; 	(nnfolder-inhibit-expiry t)
	;; 	(nnfolder-directory "~/email/Local/archive")
	;; 	(nnfolder-active-file "~/email/Local/archive/active")
	;; 	(nnfolder-get-new-mail nil)
	;; 	(nnfolder-inhibit-expiry t)
	;; 	(nnir-search-engine notmuch))
	))

(setq gnus-update-message-archive-method t)
(setq gnus-message-archive-method
      '(nnfolder "archive"
                 (nnfolder-inhibit-expiry t)
                 (nnfolder-active-file "~/email/Local/archive/active")
                 (nnfolder-directory "~/email/Local/archive/")
		 (nnfolder-get-new-mail nil)
		 (nnir-search-engine notmuch)
		 ;; (nnir-notmuch-remove-prefix "/home/wilk/email/Local/archive/")
		 ))
(setq nnmail-split-fancy
      '(|
	;; ("from" ,gnus-ignored-from-addresses "sent-mail")
	(: (lambda ()
	     (car (bbdb/gnus-split-method))))
	(from  "ne-pas-repondre@ent.iledefrance.fr" "LLG")
	(: spam-split 'spam-use-bbdb 'spam-use-bogofilter)
	("gnus-warning" "duplicat\\(e\\|ion\\) of message" "duplicate")
	;; all the rest
	"General"
	))

;; (setq nnimap-split-fancy
;;       `(|
;; 	("from" ,gnus-ignored-from-addresses "sent-mail")
;; 	(: (lambda ()
;; 		(car (bbdb/gnus-split-method))))
;; 	("gnus-warning" "duplicat\\(e\\|ion\\) of message" "duplicate")
;; 	(: spam-split 'spam-use-bogofilter)
;; 	;; all the rest
;; 	"General"
;; 	))

(setq nnmail-split-methods 'nnmail-split-fancy)
(setq nnimap-split-methods 'nnimap-split-fancy)

(setq gnus-agent-synchronize-flags t
      gnus-agent-queue-mail t
      gnus-agent-prompt-send-queue nil
      gnus-asynchronous t
      gnus-agent-go-online t
      )

;; (setq gnus-agentized-servers '("nnimap:gmail" "nnimap:free" "nntp:news.gmane.org"))
(setq gnus-agentized-servers '("nntp:news.gmane.io"))

(defun jc-gnus-open-agentized-servers ()
  (interactive)
  (let 
  ((servers gnus-agentized-servers))
    (while servers
      (gnus-open-server (car servers))
      (setq servers (cdr servers))))
  )

(defun jc-nuke-newsletter-group ()
  (gnus-group-delete-articles "nnimap+free:newsletter" t))

(eval-after-load "mail-source"
  '(add-to-list 'mail-sources
		'(file :path "/var/spool/mail/wilk"
		       )))

(eval-after-load "mail-source"
  '(add-to-list 'mail-sources
              '(pop :server "pop3.louislegrand.eu"
                    :user "julien.cubizolles"
                    :stream network
		)))

;; Duplicates
(setq gnus-suppress-duplicates t)
(setq gnus-save-duplicate-list t)



;; (setq nnmail-split-fancy 
;;       `(|
;; 	;; (: gnus-registry-split-fancy-with-parent)
;; 	("from" "louislegrand\\|LLG\\|\\(m\\|M\\)ansuy" "LLG")
;; 	("subject" "physique2013" "physique2013")
;; 	("subject" "structures2013" "structures2013")
;; 	("from" "\\(b\\|B\\)lotin\\|\\(c\\|C\\)ellier\\|\\(d\\|D\\)umax" "famille")
;; 	(: spam-split 'spam-use-bogofilter)
;; 	;; (any "\\b\\(\\w+\\)@.*bretagne.*" "ml.ups.\\1")
;; 	;; (any ".*ups-\\b\\(\\w+\\)@listes\\.prepas\\.org" "ml.ups.\\1")
;; 	("gnus-warning" "duplicat\\(e\\|ion\\) of message" "duplicate")
;; 	;; all the rest
;; 	;; "Default"
;; 	"General"
;; 	))

;; Pour ne pas écrire 20 lignes de From:
(setq gnus-treat-hide-boring-headers (quote head))
(setq gnus-boring-article-headers (quote (empty followup-to reply-to long-to)))


(setq gnus-permanently-visible-groups "INBOX")
;; default Pine ordered header list when displaying mail
(setq gnus-sorted-header-list '( "^Date:" "^From:" "^To:" "^Followup-To:" "^Cc:" "Bcc:" "^Newsgroups:" "Fcc:" "^Subject:" ))

;; Check des nouveaux articles toutes les 5 minutes pour les groupes de niveau inférieur à 3 (le Topic Loisirs est à 5 par exemple)
;; (gnus-demon-add-handler 'gnus-group-get-new-news 5 3)
;; (setq gnus-demon-timestep 1)

(gnus-demon-add-handler 'gnus-demon-scan-news 300 10)
(setq gnus-notifications-minimum-level 2)
(add-hook 'gnus-after-getting-new-news-hook 'gnus-notifications)
(setq gnus-notifications-use-gravatar nil)
(setq gnus-notifications-use-google-contacts nil)



;; (require 'gnus-desktop-notify)
;; (gnus-desktop-notify-mode)
;; (gnus-demon-add-rescan)

;; Pour ne notifier que les arrivées dans certains groupes, à customiser avec G c
;; (setq gnus-desktop-notify-groups 'gnus-desktop-notify-explicit)

;; Pour l'instant, ça buggue quand on n'utilise pas gnome comme wm
;; (require 'notifications)
;; (add-hook 'gnus-after-getting-new-news-hook 'gnus-notifications)


;; (notifications-notify
;;        :title "from"
;;        :body "subject"
;;        :actions '("read" "Read")
;;        :on-action 'gnus-notifications-action
;;        :app-icon (gnus-funcall-no-warning
;;        		  'image-search-load-path "gnus/gnus.png")
;;        :app-name "Gnus"
;;        :category "email.arrived"
;;        :timeout gnus-notifications-timeout
;;        ;; :image-path photo-file
;;        )

;; HTML DISPLAY

;;;;;;; Danjou begin
;; Follow links in w3m with browse-url
;; (add-hook 'gnus-article-mode-hook
;;           (lambda ()
;;             (set (make-local-variable 'w3m-goto-article-function)
;;                  'browse-url)))


;; verify/decrypt only if mml knows about the protocl used
;; (setq mm-verify-option 'known)
;; (setq mm-decrypt-option 'known)

;; Mise en forme des articles

(setq auth-source-debug t)
(setq debug-on-error t)
(setq imap-log t)

(require 'nnir)
; pour faire des recherches sur gmane/imap...


;; Bug avec emacs-snapshot qui n'a plus make-local-hook, il suffit d'enlever l'appel à make-local-hook dans egocentric.el
;; (add-hook 'gnus-article-prepare-hook 'egocentric-mode-on nil t)

;; (add-hook 'gnus-article-prepare-hook 'gnus-article-decode-charset)
;; (setq gnus-default-charset `utf-8-auto)
(setq gnus-treat-buttonize t)

;; Even if attached, treat as inline
;; (add-to-list 'mm-attachment-override-types "image/.*")
;; (add-to-list 'mm-attachment-override-types "message/rfc822")
;; (add-to-list 'mm-attachment-override-types "text/x-patch")

(setq gnus-blocked-images nil)


;; Posting charsets, 

;; (setq message-default-charset 'iso-8859-1) ;; Not sure if this is used
;; (setq mm-coding-system-priorities '(utf-8 iso-8859-1))

(add-to-list 'gnus-newsgroup-variables 'mm-coding-system-priorities)
(setq gnus-parameters
      (nconc
       ;; Some charsets are just examples!
       '(("^proxad\\." ;; Free n'accepte pas l'utf-8
          (mm-coding-system-priorities '(iso-8859-1)))
	 ;; (".*" (mm-coding-system-priorities '(utf-8)))
	 )
       gnus-parameters))

;; mm
; Default 
(setq mm-text-html-renderer 'shr)
;(setq mm-text-html-renderer 'gnus-w3m)
(setq mm-inline-large-images 'resize)
;(setq mm-inline-large-images t)

(setq mm-discouraged-alternatives '("text/html" "text/richtext"))
(setq mm-w3m-safe-url-regexp nil)       ; Allow all images to be retrieved :-/

;(add-to-list 'mm-automatic-external-display "application/msword")
;(add-to-list 'mm-attachment-override-types "application/msword")
;(add-to-list 'mm-automatic-display "application/msword")
(add-to-list 'mm-inlined-types "application/msword")
(add-to-list 'mm-inline-media-tests
                 '("application/msword"
                   (lambda (handle)
                     (mm-inline-render-with-stdin handle nil
                                                  "antiword" "-"))
                   identity))


;;;;;;;; Danjou end


(setq mm-inline-text-html-with-images t)

;; Pdf inline
(define-key gnus-summary-mode-map [?K ?f]
  'gnus-article-view-part-via-find-file)

(defun gnus-mime-view-part-via-find-file (&optional handle)
  (interactive)
  (gnus-article-check-buffer)
  (let ((handle (or handle (get-text-property (point) 'gnus-data))))
    (when handle
      (let* ((gnus-data (mm-handle-type (get-text-property (point)
							   'gnus-data)))
	     (ext (file-name-extension
		   (or (mail-content-type-get gnus-data 'name)
		       "dummy.txt")))
	     (suffix (concat "." ext ))
	     (f (make-temp-file "mime-part" nil suffix)))
	(mm-save-part-to-file handle f)
	(find-file f)))))

(defun gnus-article-view-part-via-find-file (n)
  "View MIME part N via find-file, which is the numerical prefix."
  (interactive "P")
  (gnus-article-part-wrapper n 'gnus-mime-view-part-via-find-file))

;; Pour envoyer les forward inline
(setq message-forward-as-mime nil)

;; Apparence

  (when (char-displayable-p ?\u2691)
    (setq gnus-ticked-mark ?⚑))

  (when (char-displayable-p ?\u2690)
    (setq gnus-dormant-mark ?⚐))

  (when (char-displayable-p ?\u2709)
    (setq gnus-unread-mark ?✉))

  (when (char-displayable-p ?\u2717)
    (setq gnus-del-mark ?✗))

  (when (char-displayable-p ?\u2713)
    (setq gnus-read-mark ?✓))

  (setq gnus-ancient-mark ? )

  (when (char-displayable-p ?\u2620)
    (setq gnus-killed-mark ?☠))

  (when (char-displayable-p ?\u2197)
    (setq gnus-canceled-mark ?↗))

  (when (char-displayable-p ?\u267B)
    (setq gnus-expirable-mark ?♻))

  (when (char-displayable-p ?\u21BA)
    (setq gnus-replied-mark ?↺))

  (when (char-displayable-p ?\u21AA)
    (setq gnus-forwarded-mark ?↪))

  (when (char-displayable-p ?\u260D)
    (setq gnus-cached-mark ?☍))

  (when (char-displayable-p ?\u2729)
    (setq gnus-unseen-mark ?✩))

  (when (char-displayable-p ?\u2699)
    (setq gnus-process-mark ?⚙))

  (when (char-displayable-p ?\u2605)
    (setq gnus-recent-mark ?★))

  (when (char-displayable-p ?\u2191)
    (setq gnus-score-over-mark ?↑))

  (when (char-displayable-p ?\u2193)
    (setq gnus-score-below-mark ?↓))

  (when (char-displayable-p ?\u1f44)
    (setq gnus-ham-mark ?👍))

(setq gnus-parameter-ham-marks-alist '((".*" ((gnus-ham-mark)))))
(setq gnus-auto-expirable-marks '(9760 10007 67 89 77)) ; killed, del, catchup, low score, duplicate

(defface gnus-summary-markup-face
  '((((class color)
      (background dark))
     (:inherit default))
    (((class color)
      (background light))
     (:inherit default))
    (t
     (:inherigt default)))
  "face used for dummy summary line format markup"
  :group 'gnus-group)

(copy-face 'gnus-summary-markup-face 'gnus-face-8)
(setq gnus-face-8 'gnus-face-8)

(copy-face 'font-lock-variable-name-face 'gnus-face-6)
(setq gnus-face-6 'gnus-face-6)

;; (copy-face 'font-lock-constant-face 'gnus-face-7)
;; (setq gnus-face-7 'gnus-face-7)
;; (copy-face 'gnus-face-7 'gnus-summary-normal-unread)
(copy-face 'gnus-summary-normal-unread 'gnus-face-7)
(setq gnus-face-7 'gnus-face-7)

;; (copy-face 'font-lock-constant-face 'gnus-face-8)
;; ;(set-face-foreground 'gnus-face-8 "gray50")
;; (setq gnus-face-8 'gnus-face-8)
(copy-face 'gnus-summary-markup-face 'gnus-face-8)
(setq gnus-face-8 'gnus-face-8)

(copy-face 'font-lock-constant-face 'gnus-face-9)
;(set-face-foreground 'gnus-face-9 "gray70")
(setq gnus-face-9 'gnus-face-9)

(setq gnus-summary-make-false-root 'dummy)
(setq gnus-summary-make-false-root-always nil)
;; (set-face-attribute 'gnus-header-subject nil :bold t :foreground  "orange2")
(defun oxy-unicode-threads () 
  (interactive)
  (setq gnus-summary-dummy-line-format "        %8{│%}    %8{│%}%O   %(%8{│%}                       %7{│%}%) %6{□%}  %S\n"
	;; gnus-summary-line-format "%8{%8d│%}%8{%4k│%}%O%9{%U%R%z%}%8{│%}%*%(%-23,23f%)%7{│%} %6{%B%} %s\n"
	gnus-summary-line-format "%8{%8&user-date;%}%9{|}%8{%4k│%}%O%9{%U%R%z%}%8{│%}%*%(%-23,23f%)%7{│%} %6{%B%} %s\n"
	gnus-sum-thread-tree-indent " "
	gnus-sum-thread-tree-root "■ "
	gnus-sum-thread-tree-false-root "□ "
	gnus-sum-thread-tree-single-indent "▣ "
	gnus-sum-thread-tree-leaf-with-other "├─▶ "
	gnus-sum-thread-tree-vertical "│"
	gnus-sum-thread-tree-single-leaf "└─▶ "))

(defun oxy-unicode-threads-heavy () 
  (interactive)
  (setq ;; gnus-summary-line-format "%8{%8d│%}%8{%4k│%}%O%9{%U%R%z%}%8{│%}%*%(%-23,23f%)%7{║%} %6{%B%} %s\n"
        gnus-summary-line-format "%8{%11&user-date;%}%9{│%}%8{%4k%}%9{│%}%O%9{%U%R%z%}%21=%9{│%}%*%(%-23,23f%)%9{║%}%6{%B%} %s\n"
	;; gnus-summary-dummy-line-format "%11=%9{│%}%16=%9{│%}%21=%9{│%}%45=%9{║%}%46=%6{┏○%}%47=%S\n"
	gnus-summary-dummy-line-format "%11=%9{│%}%8{%16=%}%9{│%}%21=%9{│%}%8{%45=%}%9{║%}%46=%6{┏○%}%47=%S\n"
	gnus-sum-thread-tree-indent " "
	gnus-sum-thread-tree-root "┏● " 
	gnus-sum-thread-tree-false-root " ○ "
	gnus-sum-thread-tree-single-indent " ● "
	gnus-sum-thread-tree-leaf-with-other "┣━━❯ " 
	gnus-sum-thread-tree-vertical "┃"
	gnus-sum-thread-tree-single-leaf "┗━━❯ "))

(oxy-unicode-threads-heavy)

(setq gnus-user-date-format-alist
      '(((gnus-seconds-today)
	. "%H:%M")
       ((+ 86400
	   (gnus-seconds-today))
	. "Hier, %H:%M")
       (604800 . "%a %H:%M")
       ((gnus-seconds-month)
	. "%a %d")
       ((gnus-seconds-year)
	. "%b %d")
       (t . "%b %d %y")))

;; (oxy-unicode-threads)

;(setq gnus-ignoredfrom-addresses (quote ("Julien Cubizolles" "j.cubizolles@free.fr")))

;;Posting

; when composing a mail, automatically make line brakes after 72 columns
(add-hook 'message-mode-hook
          (lambda ()
            (setq fill-column 72)
            (turn-on-auto-fill)
	    (flyspell-mode 1)))

; Pour choisir la langue de ispell
(add-hook 'gnus-select-group-hook
             (lambda ()
               (cond
                ((string-match
                  "gmane" (gnus-group-real-name gnus-newsgroup-name))
                 (ispell-change-dictionary "english"))
                (t
                 (ispell-change-dictionary "francais")))))

(add-hook 'message-setup-hook
             (lambda ()
	       ;; (speck-mode 1)
	       (flyspell-mode 1)
               (cond
                ((string-match
                  "gmane" (gnus-group-real-name gnus-newsgroup-name))
                 (ispell-change-dictionary "english"))
                (t
                 (ispell-change-dictionary "francais")))
	       ;; (setq speck-filter-mode 'Email)
	       ))



(setq message-kill-buffer-on-exit t)


; Pour le courrier : smtp gmail
(require 'smtpmail-async)
(setq message-send-mail-function 'smtpmail-send-it
	;; 'async-smtpmail-send-it
      send-mail-function 'smtpmail-send-it
      smtpmail-starttls-credentials '(("smtp.free.fr" 587 nil nil))
      smtpmail-auth-credentials '(("smtp.free.fr" 587 "j.cubizolles" nil))
      ;; smtpmail-default-smtp-server "smtp.gmail.com"
      ;; smtpmail-stream-type 'ssl
      ;; smtpmail-stream-type 'starttls
      smtpmail-stream-type nil
      smtpmail-default-smtp-server "smtp.free.fr"
      smtpmail-smtp-server "smtp.free.fr"
      smtpmail-smtp-service 587
      smtpmail-smtp-user "j.cubizolles"
      smtpmail-local-domain nil)

(setq gnus-gcc-mark-as-read t)

(setq gnus-message-archive-group 
      '((if (message-news-p)
            (format-time-string "sent-news-%Y-%m") 
          (format-time-string "sent-mail-%Y-%m"))))

;; Ne marche pas, il faut déterminer une autre variable que gcc-self-val comme parametre
;; (setq gnus-message-archive-group
;;       '((let
;; 	   ((string 
;; 	     (if (message-news-p) "sent-news-%Y-%m" "sent-mail-%Y-%m")))
;; 	 (concat (format-time-string string)
;; 		 (if (equal t gcc-self-val) (concat "," gnus-newsgroup-name))
;; 		 ))))

;; (defun jctest ()
;;   (let
;;       ((string 
;; 	(if (message-news-p) "sent-news-%Y-%m" "sent-mail-%Y-%m")))
;;     (concat (format-time-string string)
;; 	    (if (equal t gcc-self-val) (concat "," gnus-newsgroup-name))
;; 	    )))



(gnus-add-configuration
 '(article
   (horizontal 1.0
	       (vertical 45
			 (group 1.0))
	       (vertical 1.0
			 (summary 0.25 point)
			 (article 1.0)))))
(gnus-add-configuration
 '(summary
   (horizontal 1.0
	       (vertical 45
			 (group 1.0))
	       (vertical 1.0
			 (summary 1.0 point)))))

(gnus-add-configuration
 '(reply-yank
   (horizontal 1.0
	       (vertical 45
			 (group 1.0))
	       (vertical 1.0
			 (vertical 1.0
				   (horizontal .3 (summary 1.0))
				   (horizontal 1.0
					       (message 1.0 point)
					       (article .5)))))))


(defun wilk-gnus-browse-archived-at ()
  "Browse \"Archived-at\" URL of the current article."
  (interactive)
  (let (url)
    (with-current-buffer gnus-original-article-buffer
      (setq url (gnus-fetch-field "Archived-at")))
    (if (not (stringp url))
	(gnus-message 1 "No \"Archived-at\" header found.")
      (setq url (gnus-replace-in-string url "^<\\|>$" ""))
      (browse-url url))))

(defun wilk-gnus-browse-gwene ()
"Start a browser for current gwene article"
  (interactive)
  (dolist (buf (buffer-list))
    (with-current-buffer buf
      (when (eq major-mode 'gnus-article-mode)
	(gnus-summary-show-article '(4))
	(switch-to-buffer buf)
	(goto-char (point-min))
	(re-search-forward "^Archived-at: <\\(.*\\)>$")
	(browse-url (match-string 1))
	(gnus-summary-show-article)))))

;; Eric Fraga 
;; gnus-select-method '(nnnil "")
;; gnus-secondary-select-methods '((nnml "")
;; 				(nnimap "ucl"
;; 				   (nnimap-address "imap-server.ucl.ac.uk")
;; 				   (nnimap-inbox "INBOX")
;; 				   (nnimap-stream ssl)
;;                                    (nnimap-unsplittable-articles '(%Deleted)))
;; 			      (nnimap "google"
;; 				      (nnimap-address "imap.gmail.com")
;; 				      (nnimap-server-port 993)
;; 				      (nnimap-stream ssl)))

;; with associated entries in my .authinfo file for "ucl" and "google".
;; Note that I only specify splitting for my UCL mailbox as I use google's
;; own splitting methods on gmail.

;; Then I have the following splitting settings (abridged but keeping some
;; typical examples):

;; nnimap-split-methods 'default
;; nnmail-split-methods 'nnmail-split-fancy
;; nnmail-split-fancy 
;;       '(| (to ".*orgmode" "lists.org")
;; 	  (to ".*@gnu[s]*.org" "lists.gnus")
;; 	  (from ".*@quora.com" "social")
;; 	  (from ".*@\\(academia.edu\\|linkedin.com\\)" "social")
;; 	  ;; all the rest
;; 	 "general"
;; 	 )
;; Fraga end


;; (setq gnus-select-method
;;       '(nntp "news.gmane.org"
;;              (nntp-open-connection-function nntp-open-tls-stream)
;;              (nntp-port-number 563)
;;              (nntp-address "news.gmane.org"))
;;       gnus-secondary-select-methods
;;       '((nnimap "imap.pitt.edu"
;;                 (nnimap-server-port 993)
;;                 (nnimap-stream ssl)
;;                 (nnir-search-engine imap))
;;         (nnimap "imap.gmail.com"
;;                 (nnimap-server-port 993)
;;                 (nnimap-stream ssl)
;;                 (nnir-search-engine imap)))
;;       message-send-mail-function 'message-send-mail-with-sendmail
;;       message-sendmail-envelope-from 'header
;;       message-sendmail-f-is-evil nil
;;       sendmail-program "~/bin/msmtp-stub"
;;       user-mail-address "gardellawg@gmail.com"
;;       user-full-name "William Gardella"
;;       message-alternative-emails "pitt.edu"
;;       gnus-posting-styles
;;       '(("pitt.edu"
;;          (address "wgg2@pitt.edu")
;;          (organization "University of Pittsburgh School of Law"))
;;         ("gmane.*"
;;          (X-Archive "encrypt"))) 
;;       tls-checktrust 'ask
;;       tls-program '("gnutls-cli --x509cafile /etc/ssl/certs/ca-certificates.crt -p %p %h"
;;                     "gnutls-cli --x509cafile /etc/ssl/certs/ca-certificates.crt -p %p %h --protocols ssl3"
;;                     "openssl s_client -connect %h:%p -CAfile /etc/ssl/certs/ca-certificates.crt -no_ssl2 -ign_eof")
;;       gnus-agent-synchronize-flags t
;;       gnus-agent-queue-mail 'always
;;       gnus-agent-prompt-send-queue t
;;       gnus-asynchronous t
;;       gnus-agent-go-online t
;;       mm-text-html-renderer 'gnus-w3m
;;       gnus-summary-line-format
;;       (concat
;;        "%0{%U%R%z%}"
;;        "%4{%-20,20f%}" ;; name
;;        "  "
;;        "%3{│%}" "%1{%-20,25D%}" "%3{│%}" ;; date
;;        "  "
;;        "%1{%B%}"
;;        "%s\n")
;;       gnus-summary-display-arrow t
;;       gnus-completing-read-function 'gnus-ido-completing-read
;;       mail-user-agent 'gnus-user-agent
;;       read-mail-command 'gnus
;;       gnus-treat-display-smileys nil)
;; (autoload 'sendmail-send-it "sendmail")
