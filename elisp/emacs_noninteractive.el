;; ~/.emacs.d/emacs_noninteractive.el
;;--------------------
;; Custom paths
;;--------------------
;; dans melpa désormais
;; (add-to-list 'load-path "~/info/emacs/org-mode/lisp")
;; (add-to-list 'load-path "~/info/emacs/org-mode/contrib/lisp")
;; (add-to-list 'load-path "~/info/emacs/org-caldav")

;; Pour choisir la version de gnus indépendamment de celle d'Emacs
(setq load-path (cons (expand-file-name "/home/wilk/info/emacs/gnus/lisp") load-path))

;; (add-to-list 'load-path "/home/wilk/info/emacs/bbdb/lisp")
;; (add-to-list 'load-path "/home/wilk/info/emacs/bbdb/bits")

(add-to-list 'load-path "~/.emacs.d/gnus-bogofilter")

;; Pour Namazu
(add-to-list 'load-path "~/info/emacs/gnus/contrib")

(add-to-list 'load-path "/home/wilk/.emacs.d/bbdb-vcard")
;;--------------------
;; Custom paths end
;;--------------------

(prefer-coding-system 'utf-8)
(set-charset-priority 'unicode)
(setq default-process-coding-system '(utf-8-unix . utf-8-unix))

(require 'tramp)

;;--------------------
;; Org
;;--------------------
;; (add-to-list 'load-path "~/info/emacs/org-7.9.4/lisp")
;; (add-to-list 'load-path "~/info/emacs/org-7.9.4/contrib/lisp")
;; À charger avant org.el
(require 'cl)
(setq org-export-backends '(ascii html icalendar latex beamer odt))
(require 'org)
(setq org-directory "~/org/orgfiles/")
(setq org-default-notes-file (concat org-directory "/notes.org"))
(setq org-log-repeat nil)

;; Ça doit faire des doublons si on laisse from-mobile.org puisque ses
;; changements seront pushés par org-mobile-push ?
;; (setq org-agenda-files (quote ("~/org/orgfiles/" "~/vuibert/" "~/org/from-mobile.org")))
(setq org-agenda-files (quote ("~/org/orgfiles/" "~/vuibert/")))
;(setq org-clock-into-drawer 1)

; The following lines are always needed.  Choose your own keys.
(add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))
;; (global-set-key "\C-cl" 'org-store-link)
;; (global-set-key "\C-ca" 'org-agenda)
;; (global-set-key "\C-cb" 'org-iswitchb)

;; Pour faire commencer/finir les lignes en ignorant les * et ...
(setq org-special-ctrl-a/e t)

(setq org-export-latex-listings t)

(setq org-startup-indented t)
(setq org-hide-leading-stars t)
(setq org-enforce-todo-dependencies t)
(setq org-agenda-dim-blocked-tasks t)

(setq org-agenda-exporter-settings
      '((ps-print-color-p 'black-white)))

(eval-after-load 'ox-latex
  '(progn (add-to-list 'org-latex-classes
		       '("mpsi_beamer" "\\documentclass{mpsi_beamer}\n [NO-DEFAULT-PACKAGES]"
			 ("\\section{%s}" . "\\section*{%s}")
			 ("\\subsection{%s}" . "\\subsection*{%s}")
			 ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
			 ;; ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
			 ;; ("\\paragraph{%s}" . "\\paragraph*{%s}")
			 ;; ("\\subparagraph{%s}" . "\\subparagraph*{%s}")
			 ))
	  (add-to-list 'org-latex-classes
		       '("mpsi" "\\documentclass[cours,colonne]{mpsi}\n [NO-DEFAULT-PACKAGES]"
			 ("\\section{%s}" . "\\section*{%s}")
			 ("\\subsection{%s}" . "\\subsection*{%s}")
			 ))
	  (add-to-list 'org-latex-classes
		       '("mpsi-beamerarticle" "\\documentclass{mpsi-beamerarticle}\n [NO-DEFAULT-PACKAGES]"
			 ("\\section{%s}" . "\\section*{%s}")
			 ("\\subsection{%s}" . "\\subsection*{%s}")
			 ))
	  (add-to-list 'org-latex-classes
		       '("mpsi-beamerarticle-eleves" "\\documentclass[noVersion,eleves]{mpsi-beamerarticle}\n [NO-DEFAULT-PACKAGES]"
			 ("\\section{%s}" . "\\section*{%s}")
			 ("\\subsection{%s}" . "\\subsection*{%s}")
			 ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
			 ("\\paragraph{%s}" . "\\paragraph*{%s}")
			 ("\\subparagraph{%s}" . "\\subparagraph*{%s}")
			 ))
	 ))


;; (customize-set-variable 'org-beamer-environments-extra '(("only" "O" "\\begin{onlyenv}%a" "\\end{onlyenv}")))

(setq org-capture-templates (quote (("t" "todo" entry (file+headline "~/org/orgfiles/refile.org" "Tâches") 
  "* TODO  %? %^G     
DEADLINE:%^t" :clock-resume t)
                                    
				    ("c" "Contacts" entry (file "~/org/orgfiles/contacts.org")
				     "* %(org-contacts-template-name)
:PROPERTIES:
:EMAIL: %(org-contacts-template-email)
:END:")
				    ("n" "note" entry (file+headline "~/org/orgfiles/refile.org" "Notes")
  "* %?
  %^C" :clock-resume t)
                                    ("a" "courses" checkitem (file+headline "~/org/orgfiles/maison.org" "Courses")
  "%?
  %^C" 
  )
				    ("e" "À écouter" item (file+headline "~/org/orgfiles/loisirs.org" "À écouter")
  "%?
  %^C"
  )
				    ("l" "À lire" item (file+headline "~/org/orgfiles/loisirs.org" "À lire")
  "%?
  %^C"
  )
				    ("s" "CDs à acheter" checkitem (file+headline "~/org/orgfiles/loisirs.org" "CDs à acheter")
  "%?
  %^C"
  )
				    ("m" "maintenance" entry (file+datetree "~/org/orgfiles/info.org")
  "* %?"
  )
				    ("b" "bios" item (file+headline "~/org/orgfiles/lycee.org" "Bios")
  "%?
  %^C"
  )
				    ("T" "test" item (file+headline "~/org/orgfiles/test.org" "Test")
  " [ ] %?"
  )
)))
;(define-key global-map "\C-cc" 'org-capture)

(global-set-key (kbd "C-c C-g") (lambda () (interactive) (org-clock-in '(4))))
(global-set-key (kbd "C-c C-h") 'org-clock-out)


; Refiling
; Use IDO for target completion
(setq org-completion-use-ido t)
; Targets include this file and any file contributing to the agenda - up to 5 levels deep
(setq org-refile-targets (quote ((org-agenda-files :maxlevel . 5) (nil :maxlevel . 5))))
; Targets start with the file name - allows creating level 1 tasks
(setq org-refile-use-outline-path (quote file))
; Targets complete in steps so we start with filename, TAB shows the next level of targets etc
(setq org-outline-path-complete-in-steps t)
; Allow refile to create parent tasks with confirmation
(setq org-refile-allow-creating-parent-nodes (quote confirm))


; global Effort estimate values
(setq org-global-properties (quote (("Effort_ALL" . "0:10 0:30 1:00 2:00 3:00 4:00 5:00 6:00 7:00 8:00 10:00"))))


(setq org-todo-keywords 
      (quote (
	      (sequence "TODO(t)" "STARTED(s!/@)" "|" "DONE(d!/@)")
	      (sequence "WAITING(w@/!)" "SOMEDAY(S!)" "|" "CANCELLED(c@/!)")
	      (sequence "BUG(!)" "REPORTED(!)" "|" "FIXED(@)" "WONTFIX(@/@)")
)))

(setq org-todo-keyword-faces 
(quote (
 ("TODO" :foreground "red1" :weight bold)
 ("STARTED" :foreground "magenta" :weight bold)
 ("DONE" :foreground "yellow green" :weight bold)
 ("WAITING" :foreground "orange" :weight bold)
 ("SOMEDAY" :foreground "plum" :weight bold)
 ("CANCELLED" :foreground "yellow green" :weight bold)
 ("BUG" :foreground "red1" :weight bold)
 ("REPORTED" :foreground "slate blue" :weight bold)
 ("FIXED" :foreground "yellow green" :weight bold)
 ("WONTFIX" :foreground "yellow green" :weight bold)
)))

(setq org-log-into-drawer t)
;(setq org-property-inheritance (list "CLOCK_MODELINE_TOTAL"))
(setq org-property-inheritance t)

;Clocking
;;
(setq org-agenda-clockreport-parameter-plist (quote (:link t :maxlevel 4)))
;; Keep clocks running
;(setq org-remember-clock-out-on-exit nil)
;; Resume clocking tasks when emacs is restarted
(org-clock-persistence-insinuate)
;; Yes it's long... but more is better ;)
(setq org-clock-history-length 5)
;; Resume clocking task on clock-in if the clock is open
(setq org-clock-in-resume t)
;; Do not prompt to resume an active clock
;(setq org-clock-persist-query-resume nil)
;; Save the running clock and all clock history when exiting Emacs, load it on startup
(setq org-clock-persist t)

;; Change task state to STARTED from TODO when clocking in
(defun jc/clock-in-to-started (kw)
  "Switch task from TODO to STARTED when clocking in"
  (if (and (string-equal kw "TODO")
           (not (string-equal (buffer-name) "*Remember*")))
      "STARTED"
    nil))

(setq org-clock-in-switch-to-state (quote jc/clock-in-to-started))
;; Change task state to STARTED when clocking in
;(setq org-clock-in-switch-to-state "STARTED")
;; Separate drawers for clocking and logs
(setq org-drawers (quote ("PROPERTIES" "LOGBOOK" "CLOCK")))
;; Save clock data in the CLOCK drawer and state changes and notes in the LOGBOOK drawer
(setq org-clock-into-drawer "CLOCK")
;; Sometimes I change tasks I'm clocking quickly - this removes clocked tasks with 0:00 duration
(setq org-clock-out-remove-zero-time-clocks t)
;; Don't clock out when moving task to a done state
(setq org-clock-out-when-done nil)
;; Save the running clock and all clock history when exiting Emacs, load it on startup
(setq org-clock-persist (quote history))
;; Disable auto clock resolution
(setq org-clock-auto-clock-resolution nil)
;; Remove empty CLOCK drawers on clock out
(defun jc/remove-empty-drawer-on-clock-out ()
  (interactive)
  (save-excursion
    (beginning-of-line 0)
    (org-remove-empty-drawer-at "CLOCK" (point))))

(add-hook 'org-clock-out-hook 'jc/remove-empty-drawer-on-clock-out 'append)
;(defun jc/clock-in-interrupted-task ()    
;  "Clock in the interrupted task if there is one"
;  (interactive)
;  (if (and (not org-clock-resolving-clocks-due-to-idleness)
;           (marker-buffer org-clock-marker)
;           (marker-buffer org-clock-interrupted-task))
;      (org-with-point-at org-clock-interrupted-task
;        (org-clock-in nil))
;    (org-clock-out)))

;TAGS
; Tags with fast selection keys
(setq org-tag-alist (quote ((:startgroup)
                            ("@enville" . ?v)
                            ("@lycée" . ?l)
                            ("@girodet" . ?h)
                            ("@province" . ?o)
                            (:endgroup)
                            ("classe" . ?s)
                            ("labo" . ?b)
                            ("TEL" . ?T)
                            ("EMAIL" . ?E)
                            ("SNAILMAIL" . ?S)
                            ("GIRODET" . ?H)
                            ("NEXT" . ?n)
                            ("WAITING" . ?w)
                            ("lycée" . ?L)
                            ("ORG" . ?O)
                            ("loisirs" . ?f)
;                            ("crypt" . ?c)
                            ("Méliné" . ?b)
                            ("Caro" . ?c)
                            ("project" . ?P)
                            ("achat" . ?a)
                            ("CANCELLED" . ?C))))

(setq org-todo-state-tags-triggers
      (quote (("CANCELLED" ("CANCELLED" . t))
              ("WAITING" ("WAITING" . t) ("NEXT"))
	      ("REPORTED" ("WAITING" . t) ("NEXT"))
              (done ("NEXT") ("WAITING"))
              ("TODO" ("WAITING") ("CANCELLED") ("NEXT"))
              ("STARTED" ("WAITING"))
              ("DONE" ("WAITING") ("CANCELLED") ("NEXT")))))


;Agenda views

;; Toujours suivre le fichier
(setq org-agenda-start-with-follow-mode t)
;; Keep tasks with dates off the global todo lists
(setq org-agenda-todo-ignore-with-date nil)
;; Allow deadlines which are due soon to appear on the global todo lists
(setq org-agenda-todo-ignore-deadlines (quote far))
;; Keep tasks scheduled in the future off the global todo lists
(setq org-agenda-todo-ignore-scheduled (quote future))
;; Remove completed deadline tasks from the agenda view
(setq org-agenda-skip-deadline-if-done t)
;; Remove completed scheduled tasks from the agenda view
(setq org-agenda-skip-scheduled-if-done t)
;; Remove completed items from search results
(setq org-agenda-skip-timestamp-if-done t)
;; Always highlight the current agenda line
(add-hook 'org-agenda-mode-hook '(lambda () (hl-line-mode 1)))
(setq org-agenda-ndays 2)
(setq org-agenda-start-on-weekday nil)
(setq org-agenda-sticky t)

(setq org-agenda-custom-commands
      (quote (;; ("k" "TEST"
	      ;;  ((agenda ""
	      ;; 	((org-agenda-entry-types '(:timestamp))))
	      ;; 	(tags-todo "classe")
	      ;; 	(tags-todo "labo")
	      ;; 	(tags-todo "@lycée-classe-labo")
	      ;; 	)
	      ;;  ((org-agenda-filter-preset '("-girodet")))
	      ;;  )
	      ("wl" "Agenda et tâches au lycée"
	       ((agenda "lycée"
		((org-agenda-entry-types '(:timestamp))(org-agenda-ndays 2)))
		(tags-todo "classe")
		(tags-todo "labo")
		(tags-todo "@lycée-classe-labo")
		)
	       ;((org-agenda-filter-preset '("+lycée")))
               nil
	       ;; ("~/tmp/lycee.pdf")
	       )
	      ("wh" "Agenda et tâches pour la maison"
	       ((agenda "girodet"
		((org-agenda-entry-types '(:timestamp))))
		(tags-todo "@girodet")
		(tags "GIRODET"))
	       ((org-agenda-filter-preset '("+GIRODET")))
	       ;; ("~/tmp/girodet.pdf")
	       )
	      ("wv" "Agenda et tâches pour le bouquin"
	       ((agenda "vuibert"
		((org-agenda-entry-types '(:timestamp :deadline :scheduled))(org-agenda-ndays 7)))
		(tags-todo "vuibert"))
	       ((org-agenda-filter-preset '("+vuibert"))))
	      ;; ("ws" "Courses"
	      ;;  ((search "Courses"))
	      ;;  nil 
	      ;;  ;; ("~/tmp/courses.pdf")
	      ;;  )
	      ;; ("S" "Started Tasks" todo "STARTED" ((org-agenda-todo-ignore-scheduled nil)
              ;;                                      (org-agenda-todo-ignore-deadlines nil)
              ;;                                      (org-agenda-todo-ignore-with-date nil)))
	      ;; ("p" "Planning Tasks" todo "TODO+STARTED" ((org-agenda-todo-ignore-scheduled t)
              ;;                                      (org-agenda-todo-ignore-deadlines nil)
              ;;                                      (org-agenda-todo-ignore-with-date nil)))
	      ;; ("D" "Done Tasks" todo "DONE" ((org-agenda-todo-ignore-scheduled nil)
              ;;                                      (org-agenda-todo-ignore-deadlines nil)
              ;;                                      (org-agenda-todo-ignore-with-date nil)))
	      ;; ("K" "Cancelled Tasks" todo "CANCELLED" ((org-agenda-todo-ignore-scheduled nil)
              ;;                                      (org-agenda-todo-ignore-deadlines nil)
              ;;                                      (org-agenda-todo-ignore-with-date nil)))
; 	      ("O" "Tâches orphelines" alltodo "" ((org-agenda-todo-ignore-timestamp  (quote all))))
	      ;; ("O" "Tâches orphelines" alltodo "" ((org-agenda-todo-ignore-with-date t)))
              ;; ("W" "Tasks waiting on something" tags "WAITING/!" ((org-use-tag-inheritance nil)
              ;;                                                     (org-agenda-todo-ignore-with-date nil)
              ;;                                                     (org-agenda-todo-ignore-deadlines nil)
              ;;                                                     (org-agenda-todo-ignore-scheduled nil)))
              ;; ("R" "Refile New Notes and Tasks" tags "LEVEL=2+REFILE" ((org-agenda-todo-ignore-with-date nil)
              ;;                                                          (org-agenda-todo-ignore-deadlines nil)
              ;;                                                          (org-agenda-todo-ignore-scheduled nil)))
              ;; ("N" "Notes" tags "NOTE" nil)
              ;; ("n" "Next" tags "NEXT-WAITING-CANCELLED/!" nil)
              ;; ("P" "Projects" tags-todo "project-WAITING-CANCELLED/!-DONE" nil)
              ;; ("wc" "Temps de cerveau..." tags "LEVEL>2+lire|LEVEL>2+ecouter|LEVEL>=2+voir" nil)
              ;; ("A" "Tasks to be Archived" tags "LEVEL=2/DONE|CANCELLED" nil)
              ;; ("H" "Habits" tags "STYLE=\"habit\""
	      ;;  ((org-agenda-todo-ignore-with-date nil)
	      ;; 	(org-agenda-todo-ignore-scheduled nil)
	      ;; 	(org-agenda-todo-ignore-deadlines nil)))
	      )))



(setq org-stuck-projects (quote ("projet/!-DONE-CANCELLED" nil ("NEXT") "")))

; Enable habit tracking (and a bunch of other modules)
(setq org-modules (quote (org-habit org-gnus org-bbdb org-info)))

; global STYLE property values for completion
(setq org-global-properties (quote (("STYLE_ALL" . "habit"))))
; position the habit graph on the agenda to the right of the default
(setq org-habit-graph-column 50)
(run-at-time "08:00" 86400 '(lambda () (setq org-habit-show-habits t)))


; Divers
(setq org-special-ctrl-k t) 
;When t, the following will happen while the cursor is in the headline:
;- When the cursor is at the beginning of a headline, kill the entire
;  line and possible the folded subtree below the line.
;- When in the middle of the headline text, kill the headline up to the tags.
;- When after the headline text, kill the tags.

; Fonction pour effacer en mode "bulk" des items d'un agenda
(defun bulk-cut ()
  (interactive "P")
  (let* ((marker (or (org-get-at-bol 'org-hd-marker)
		     (org-agenda-error)))
	 (buffer (marker-buffer marker)))
    (with-current-buffer buffer
      (save-excursion
	(save-restriction
	  (widen)
	  (goto-char marker)
	  (org-back-to-heading t)
	  (org-cut-subtree))))))
(setq org-agenda-bulk-custom-functions 
      '((?C bulk-cut)))

(require 'org-inlinetask)
;; C-c C-x t org-inline-task-insert-task

(setq org-fontify-done-headline t)

;OrgMobile

(setq org-mobile-directory "~/Dropbox/MobileOrg")
(setq org-mobile-inbox-for-pull "~/org/from-mobile.org")




;; Org-caldav
;; installé manuellement dans les répertoires de ~/info/emacs/org... à déplacer maintenant que org est avec melpa
;; (require 'org-caldav)
;; (setq org-caldav-url "https://www.google.com/calendar/dav")
;; (setq org-caldav-calendar-id "0fseo5jbfp99polnfc6ic38h88@group.calendar.google.com")
;; (setq org-caldav-inbox "~/org/org-caldav.org")
;; (setq org-caldav-files (quote ("~/org/orgfiles/maison.org" "~/org/orgfiles/vuibert.org" "~/org/orgfiles/lycee.org" "~/org/orgfiles/science.org" "~/org/orgfiles/loisirs.org" "~/org/orgfiles/info.org" "~/org/orgfiles/famille.org")))
;; (setq org-icalendar-timezone "Europe/Paris")

(org-babel-do-load-languages
 'org-babel-load-languages
 '((R . t)
   (calc . t)
   (ditaa . t)
   (dot . t)
   (emacs-lisp . t)
   (gnuplot . t)
   (haskell . nil)
   (latex . t)
   (ledger . t)         
   (ocaml . nil)
   (octave . t)
   (python . t)
   (ruby . t)
   (screen . nil)
   (sh . t)
   (sql . nil)
   (sqlite . t)))
;; ou
;; (require 'ob-calc)

(with-eval-after-load 'ox
  ;; (defun jc-org-latex-ignore-heading (headline backend info)
  ;;   "Strip headline from HEADLINE if it has tag ignoreheading for
  ;;     certain headlines.  `info' is ignored"
  ;;   (when (and (org-export-derived-backend-p backend 'latex 'html 'ascii 'odt)
  ;; 	       (string-match "\\`.*ignoreheading.*\n"
  ;; 			     (downcase headline)))
  ;;     (replace-match "" nil nil headline)))
  (defun jc-org-latex-ignore-heading (headline backend info)
  "Strip headline from HEADLINE if it has tag ignoreheading."
  (when (org-export-derived-backend-p backend 'latex)
    (let ((tags (org-element-property :tags
				      (plist-get
				       (text-properties-at
					(or (string-match ".?\\(\\\\hfill\\|}\n\\)" headline) 0) headline)
				       :parent))))
      (when (and tags (member-ignore-case "ignoreheading" tags))
	(string-match "\\`.*\n.*\n" headline)
	(replace-match "" nil nil headline)))))
  (add-to-list 'org-export-filter-headline-functions
	       'jc-org-latex-ignore-heading))



(defun remove-org-suffix (name)
  "Remove the .org from a file name"
  (if (string-match "\\(.*\\)\\.org" name)
      (substring name (match-beginning 1) (match-end 1))
    name))

(defun jc-org-publish-rename-pdf (suffix)
    "Rename file.pdf to file-suffix.pdf when buffer is visiting file.org"
  (let*   ((file-base-name (remove-org-suffix (buffer-file-name)))
  (file-pdf-name (concat file-base-name ".pdf"))
  (file-suffix-pdf-name (concat file-base-name "-" suffix  ".pdf")))
  (if (file-exists-p file-pdf-name)
      (rename-file file-pdf-name file-suffix-pdf-name 1))
    )
  )

(defun jc-org-publish-rename (suffix version)
    "Rename file.suffix to file-version.suffix when buffer is visiting file.org"
    (let*   ((file-base-name (remove-org-suffix (buffer-file-name)))
	     (file-suffix-name (concat file-base-name "." suffix))
	     (file-version-suffix-name (concat file-base-name "-" version  "." suffix)))
    (if (file-exists-p file-suffix-name)
	(rename-file file-suffix-name file-version-suffix-name 1))
    )
    )


(defun jc-org-publish-rename-notes-pdf ()
  "Rename file.pdf to file-notes.pdf when buffer is visiting file.org"
  (jc-org-publish-rename-pdf '"notes"))

(defun jc-org-publish-rename-eleves-pdf ()
  "Rename file.pdf to file-figures-exos.pdf when buffer is visiting file.org"
  ;; (jc-org-publish-rename-pdf '"eleves")
  (jc-org-publish-rename '"pdf" '"eleves")
  (jc-org-publish-rename '"tex" '"eleves")
  )

(defun jc-org-publish-rename-beamer-pdf ()
  "Rename file.pdf to file-beamer.pdf when buffer is visiting file.org"
  (jc-org-publish-rename-pdf '"beamer"))

(defun jc-org-latex-notes-preparation ()
  "Preparation functions to be run before actually pubishing"
  ;; (progn (setq org-latex-title-command "")
  ;;   (org-latex-publish-to-pdf))
  (setq org-latex-title-command "")
  )

(setq org-export-in-background nil)


(defun jc-org-publish-project-options (backend)
  (setq org-publish-project-alist
        `(("TeX"
           :base-directory "./"
           :publishing-directory "./"
           :publishing-function org-beamer-publish-to-latex
           :exclude ".*"
           :latex-class "mpsi_beamer"
           :include , (list (file-name-nondirectory buffer-file-name))
           )
          ("beamer"
           :base-directory "./"
           :publishing-directory "./"
           :publishing-function org-beamer-publish-to-pdf
           :exclude ".*"
           :latex-class "mpsi_beamer"
	   :include , (list (file-name-nondirectory buffer-file-name))
           :completion-function jc-org-publish-rename-beamer-pdf)
          ("notes-legacy"
           :base-directory "./"
           :publishing-directory "./"
           :publishing-function org-beamer-publish-to-pdf
           :exclude ".*"
           :latex-class "mpsi_beamer"
	   :include , (list (file-name-nondirectory buffer-file-name))
           :latex-class-options "[NotesCours]"
           :completion-function jc-org-publish-rename-notes-pdf
           )
          ("notes"
           :base-directory "./"
           :publishing-directory "./"
           :preparation-function jc-org-latex-notes-preparation
           :publishing-function org-beamer-publish-to-pdf
           :exclude ".*"
           :latex-class "mpsi-beamerarticle"
	   :include , (list (file-name-nondirectory buffer-file-name))
           :completion-function jc-org-publish-rename-notes-pdf
           )
          ("eleves-legacy"
           :base-directory "./"
           :publishing-directory "./"
           :preparation-function jc-org-latex-notes-preparation
           :publishing-function org-latex-publish-to-pdf
           :exclude ".*"
           :latex-class "mpsi-eleves"
	   :include , (list (file-name-nondirectory buffer-file-name))	   
           :select-tags ("eleves")
           :headline-levels 5
           :completion-function jc-org-publish-rename-eleves-pdf
           )
          ("eleves"
           :base-directory "./"
           :publishing-directory "./"
           :preparation-function jc-org-latex-notes-preparation
           :publishing-function org-beamer-publish-to-pdf
           :exclude ".*"
           :latex-class "mpsi-beamerarticle-eleves"
	   :include , (list (file-name-nondirectory buffer-file-name))
           :select-tags ("eleves")
           :completion-function jc-org-publish-rename-eleves-pdf
           )
          ("cours" :components ("beamer" "notes"))))
  )

;; (add-hook 'org-mode-hook 'jc-org-publish-project-options)
;; (add-hook 'org-export-before-processing-hook 'jc-org-publish-project-options)

;;--------------------
;; Org end
;;--------------------

;;------------------------------
;; Gnus 
;;------------------------------

;; (setq load-path (cons (expand-file-name "/usr/share/emacs/23.2/lisp/gnus") load-path))
(require 'gnus-load)
;; ;; To enable reading the Gnus manual, you could say something like:


(setq user-full-name "Julien Cubizolles")
(setq user-mail-address "j.cubizolles@free.fr")

(require 'bbdb)
;; (require 'bbdb-loaddefs)
(bbdb-initialize 'gnus 'message)
(bbdb-mua-auto-update-init 'gnus 'message)

(add-hook 'mail-setup-hook 'bbdb-mail-aliases)
;; (add-hook 'mail-mode-hook 'bbdb-mail-aliases)
(add-hook 'message-setup-hook 'bbdb-mail-aliases)
;; (add-hook 'message-mode-hook 'bbdb-mail-aliases)
;; (mail-abbrevs-setup)
(add-hook 'message-mode-hook
	  (lambda ()
	    (define-key message-mode-map [C-tab] 'bbdb-complete-mail)
	    (define-key message-mode-map "\C-c\C-f\C-g" 'message-goto-gcc)
	    )
	  )

(defun message-goto-gcc ()
  "Move point to the Gcc header."
  (interactive)
  (push-mark)
  (message-position-on-field "Gcc" "Bcc" "Cc" "To"))

;; Cleanup all Gnus buffers on exit

(defun exit-gnus-on-exit ()
  (if (and (fboundp 'gnus-group-exit)
	   (gnus-alive-p))
      (with-current-buffer (get-buffer "*Group*")
	(let (gnus-interactive-exit)
	  (gnus-group-exit)))))

(add-hook 'kill-emacs-hook 'exit-gnus-on-exit)

(setq mm-coding-system-priorities '(iso-8859-1))
;;------------------------------
;; Gnus end 
;;------------------------------

;;--------------------
;; Namazu
;;--------------------

(require 'gnus-namazu)
;; (setq gnus-namazu-index-directories '("/home/wilk/Mail/namazu/"))
(setq gnus-namazu-index-directories '("/home/wilk/News/namazu/"))
(gnus-namazu-insinuate)
;; (setq gnus-namazu-make-index-command "mknmz")
(setq gnus-namazu-make-index-arguments
      '("--all" "--mailnews" "--deny=^.*[^0-9].*$" "--exclude=(Junk)")) 
; on cherche avec C-c C-n		;
;; (defun wilk-gnus-update-namazu-index ()
;;   (run-at-time "6:00am" nil 'wilk-gnus-namazu-update-all-indices))

;(setq gnus-namazu-index-update-interval nil) ;
;; call explicitely M-x gnus-namazu-update-all-indices

;; (defun wilk-gnus-namazu-update-all-indices ()
;;   (interactive)
;;   (gnus-namazu-update-all-indices t))

;;--------------------
;; Namazu end
;;--------------------

;;--------------------
;; Bbdb
;;--------------------
;; file where things will be saved
; (setq bbdb-file "~/.emacs.d/bbdb")	;

;; What do we do when invoking bbdb interactively
(setq bbdb-mua-update-interactive-p '(query . create))

;; Make sure we look at every address in a message and not only the
;; first one
(setq bbdb-message-all-addresses t)

;; use ; on a message to invoke bbdb interactively
(add-hook
 'gnus-summary-mode-hook
 (lambda ()
   (define-key gnus-summary-mode-map (kbd ";") 'bbdb-mua-display-records)
   )

 (require 'bbdb-anniv))
;; (add-hook 'list-diary-entries-hook #'bbdb-include-anniversaries)
(setq bbdb-read-name t)
(setq bbdb-name-format 'last-first)
(setq bbdb-read-name-format 'last-first)
(define-key bbdb-mode-map "r" 'bbdb-merge-records)

(setq bbdb-north-american-phone-numbers-p nil)
(bbdb-initialize 'gnus)

(require 'bbdb-vcard)
(setq bbdb-quiet-about-name-mismatches t
      bbdb-complete-name-allow-cycling t)
(setq bbdb-electric nil)

(setq bbdb-completion-list t); complete on names, not email addresses!
(setq bbdb-complete-mail-allow-cycling t)
(setq bbdb-message-pop-up t)
(setq bbdb-pop-up-window-size 4)

;; (require 'bbdb-)
;; If necessary, customize arbitrarily. About item of customize, eval the following sexp.
;; (customize-group "bbdb-")
;; Do setup
;; (bbdb-:setup)
;;--------------------
;; Bbdb end
;;--------------------



;;--------------------
;; Diary
;;-------------------
(calendar-set-date-style 'european)
(setq european-calendar t)
(setq calendar-week-start-day 1
      calendar-day-name-array
      ["Dimanche" "Lundi" "Mardi" 
       "Mercredi" "Jeudi" "Vendredi" "Samedi"]
      calendar-month-name-array
      ["Janvier" "Février" "Mars" "Avril"
       "Mai" "Juin" "Juillet" "Août" "Septembre"
       "Octobre" "Novembre" "Décembre"])
(defvar calendar-day-abbrev-array
  ["dim" "lun" "mar" "mer" "jeu" "ven" "sam"])
(defvar calendar-month-abbrev-array
  ["jan" "fév" "mar" "avr" "mai" "jun"
   "jul" "aou" "sep" "oct" "nov" "déc"])


(defun diary-relative (n day)
  "Diary entry that will always appear N days from today"
  (=
   (calendar-absolute-from-gregorian date)
   (+ n (calendar-absolute-from-gregorian day))))

(defun diary-tomorrow ()
  "Diary entry for tomorrow."
  (diary-relative 1))


(setq mark-diary-entries-in-calendar t)
(defun getcal (url)
  "Download ics file and add to diary"
  (let ((tmpfile (url-file-local-copy url)))
    (icalendar-import-file tmpfile "~/diary" t)
    (kill-buffer (car (last (split-string tmpfile "/"))))
    )
  )
(setq google-calendars '(
                         "https://www.google.com/calendar/ical/09qqpld5o29tddmmv92dse1tng%40group.calendar.google.com/private-b7bd6d0c40440628064a7f8fb423ddb4/basic.ics"
;;                         ""
                         ))
(defun getcals ()
  (find-file "~/diary")
  (flush-lines "^[& ]")
  (dolist (url google-calendars) (getcal url))
  (kill-buffer "diary"))

;; à évaluer pour mettre à jour les agendas google
;(getcals)

;; à évaluer pour imprimer le calendrier avec les entrées du diary
;(setq cal-tex-diary t)
; C-u 12 t m dans le calendrier pour imprimer une année entière

(setq org-agenda-include-diary t)

;; === DATES-HEURES-CALENDRIER hhh === (http://kib2.free.fr/Articles/Emacs_my_love.html#obtenir-un-calendrier-au-format-paysage)
;; ===================================
;; Heure-Dates
;; La semaine commence le lundi
(setq calendar-week-start-day 1)
(setq display-time-24hr-format t)
(setq display-time-day-and-date t)
(display-time)
;; vacances
(setq mark-holidays-in-calendar t
      general-holidays nil
      hebrew-holidays nil
      islamic-holidays nil
      bahai-holidays nil
      oriental-holidays nil)
(setq local-holidays
      '((holiday-fixed 5 1 "Fête du travail")
        (holiday-fixed 5 8 "Victoire 1945")
        (holiday-fixed 7 14 "Fête nationale")
        (holiday-fixed 8 15 "Assomption")
        (holiday-fixed 11 1 "Toussaint")
        (holiday-fixed 11 11 "Armistice 1918")
        (holiday-float 5 0 2 "Fête des mères")
        (holiday-float 6 0 3 "Fête des pères")))

;; voir les entrees de diary dans LaTeX calendar
(setq cal-tex-diary t)

;; calendrier Français
(setq european-calendar-style 't)
(setq calendar-week-start-day 1)
(setq calendar-day-name-array
["Dimanche" "Lundi" "Mardi" "Mercredi" "Jeudi" "Vendredi" "Samedi"])
(setq calendar-month-name-array
["Janvier" "Février" "Mars" "Avril" "Mai" "Juin" "Juillet"
"Août" "Septembre" "Octobre" "Novembre" "Décembre"])

;; fancy diary display
(add-hook 'diary-display-hook 'fancy-diary-display)

;; LaTeX calendar hook
 (add-hook 'cal-tex-hook 'beau-calendrier)

 (defun beau-calendrier ()
   "Se charge d'ajouter des options après avoir trouvé la ligne \\documentclass."
   (goto-char (point-min))
   (search-forward-regexp "^\\\\documentclass" 500)
   (beginning-of-line 2)
   (insert "\\usepackage{ucs}\n")
   (insert "\\usepackage[utf8]{inputenc}\n")
   (insert "\\usepackage[dvips,a4paper,landscape,margin=8mm]{geometry}\n")
   )
;;--------------------
;; Diary end
;;--------------------
