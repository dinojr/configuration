;; ~/emacs.d/JCorg.el -*- mode: lisp-*-

;; Loaded from melpa
;; (add-to-list 'load-path "~/info/emacs/org-mode/lisp")
;; (add-to-list 'load-path "~/info/emacs/org-mode/contrib/lisp")
(require 'org)
(require 'cl)

(setq org-export-backends '(ascii html icalendar latex beamer odt))
(eval-after-load "ox"
  '(setq org-export-in-background t))


(set-face-attribute 'org-level-1 nil :height 1.0)
(set-face-attribute 'org-level-2 nil :height 1.0)
(set-face-attribute 'org-level-3 nil :height 1.0)

(add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))

(setq org-insert-todo-heading-respect-content t)
(setq org-insert-heading-respect-content t)
(setq org-src-fontify-natively t)

(setq org-special-ctrl-a/e t)

(setq org-startup-indented t)
(setq org-hide-leading-stars t)
(setq org-enforce-todo-dependencies t)

(setq org-default-notes-file (concat org-directory "/notes.org"))

(setq org-log-repeat nil)
(setq org-log-into-drawer t)

(setq org-property-inheritance t)

(setq org-fontify-done-headline t)

;; Images
(setq org-startup-with-inline-images t)
(setq org-image-actual-width '(300))
;; overrided by #+ATTR.*: width=200

;; Agenda
(setq org-agenda-dim-blocked-tasks t)
(setq org-agenda-menu-show-match nil
      org-agenda-menu-two-column t)
(setq org-agenda-exporter-settings
      '((ps-print-color-p 'black-white)))
(setq org-agenda-include-diary t)

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

;; Fichiers
(setq org-directory "~/org/orgfiles/")
(setq org-agenda-files "~/org/orgfiles/liste-agendas.org")

;; todo
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

(setq org-todo-keywords
      '((sequence "TODO(t)" "|" "DONE(d)")
	(sequence "WAITING(w)" "|" "DONE(d)")
	(sequence "REPORT(r)" "BUG(b)" "KNOWNCAUSE(k)" "|" "FIXED(f)")
	(sequence "|" "CANCELED(c)")
	(sequence "SOMEDAY(s)" "|" "CANCELED(c)" "DONE(d)")))

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


;TAGS
; Tags with fast selection keys
(setq org-tag-alist (quote ((:startgroup)
                            ("@enville" . ?v)
                            ("@lycée" . ?l)
                            ("@girodet" . ?h)
                            ("@province" . ?o)
                            (:endgroup)
                            ("classe" . ?s)
			    ("eleves" . ?e)
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


;; Agenda views

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

(setq org-beamer-environments-extra
      '(("action" "k" "\\begin{actionenv}%a" "\\end{actionenv}") 
	("only" "O" "\\begin{onlyenv}%a" "\\end{onlyenv}")
	("Definition" "D" "\\begin{DefiniTion}%a%U" "\\end{DefiniTion}")
	("Indispensable" "I" "\\begin{indispensable}%a" "\\end{indispensable}")
	("Consequence" "S" "\\begin{Consequence}%a%U" "\\end{Consequence}")
	("Block" "B" "\\begin{Block}%a" "\\end{Block}")
	("Theoreme" "T" "\\begin{Theoreme}%a%U" "\\end{Theoreme}")
	("Exemple" "X" "\\begin{Exemple}%a%U" "\\end{Exemple}")))

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
    (when (file-exists-p file-suffix-name)
	(rename-file file-suffix-name file-version-suffix-name t)
	(if (equal suffix "pdf")
	    (org-open-file file-version-suffix-name)))
    )
    )


(defun jc-org-publish-rename-notes-pdf ()
  "Rename file.pdf to file-notes.pdf and file.tex to file-notes.tex when buffer is visiting file.org"
  (jc-org-publish-rename '"pdf" '"notes")
  (jc-org-publish-rename '"tex" '"notes"))

(defun jc-org-publish-rename-eleves-pdf ()
  "Rename file.pdf to file-eleves.pdf and file.tex to file-eleves.tex when buffer is visiting file.org"
  ;; (jc-org-publish-rename-pdf '"eleves")
  (jc-org-publish-rename '"pdf" '"eleves")
  (jc-org-publish-rename '"tex" '"eleves")
  )

(defun jc-org-publish-rename-beamer-pdf ()
  "Rename file.pdf to file-beamer.pdf and file.tex to file-beamer.tex when buffer is visiting file.org"
  (jc-org-publish-rename '"pdf" '"beamer")
  (jc-org-publish-rename '"tex" '"beamer"))

(defun jc-org-latex-notes-preparation ()
  "Preparation functions to be run before actually pubishing"
  ;; (progn (setq org-latex-title-command "")
  ;;   (org-latex-publish-to-pdf))
  (setq org-latex-title-command "")
  )

(setq org-export-in-background nil)


;; (defun jc-org-publish-project-options (backend)
;;   (setq org-publish-project-alist
;;         `(("TeX"
;;            :base-directory "./"
;;            :publishing-directory "./"
;;            :publishing-function org-beamer-publish-to-latex
;;            :exclude ".*"
;;            :latex-class "mpsi_beamer"
;;            :include , (list (file-name-nondirectory buffer-file-name))
;;            )
;;           ("beamer"
;;            :base-directory "./"
;;            :publishing-directory "./"
;;            :publishing-function org-beamer-publish-to-pdf
;;            :exclude ".*"
;;            :latex-class "mpsi_beamer"
;; 	   :include , (list (file-name-nondirectory buffer-file-name))
;;            :completion-function jc-org-publish-rename-beamer-pdf)
;;           ("notes-legacy"
;;            :base-directory "./"
;;            :publishing-directory "./"
;;            :publishing-function org-beamer-publish-to-pdf
;;            :exclude ".*"
;;            :latex-class "mpsi_beamer"
;; 	   :include , (list (file-name-nondirectory buffer-file-name))
;;            :latex-class-options "[NotesCours]"
;;            :completion-function jc-org-publish-rename-notes-pdf
;;            )
;;           ("notes"
;;            :base-directory "./"
;;            :publishing-directory "./"
;;            :preparation-function jc-org-latex-notes-preparation
;;            :publishing-function org-beamer-publish-to-pdf
;;            :exclude ".*"
;;            :latex-class "mpsi-beamerarticle"
;; 	   :include , (list (file-name-nondirectory buffer-file-name))
;;            :completion-function jc-org-publish-rename-notes-pdf
;;            )
;;           ("eleves-legacy"
;;            :base-directory "./"
;;            :publishing-directory "./"
;;            :preparation-function jc-org-latex-notes-preparation
;;            :publishing-function org-latex-publish-to-pdf
;;            :exclude ".*"
;;            :latex-class "mpsi-eleves"
;; 	   :include , (list (file-name-nondirectory buffer-file-name))	   
;;            :select-tags ("eleves")
;;            :headline-levels 5
;;            :completion-function jc-org-publish-rename-eleves-pdf
;;            )
;;           ("eleves"
;;            :base-directory "./"
;;            :publishing-directory "./"
;;            :preparation-function jc-org-latex-notes-preparation
;;            :publishing-function org-beamer-publish-to-pdf
;;            :exclude ".*"
;;            :latex-class "mpsi-beamerarticle-eleves"
;; 	   :include , (list (file-name-nondirectory buffer-file-name))
;;            :select-tags ("eleves")
;;            :completion-function jc-org-publish-rename-eleves-pdf
;;            )
;;           ("cours" :components ("beamer" "notes"))))
;;   )

;; (add-hook 'org-mode-hook 'jc-org-publish-project-options)
;; (add-hook 'org-export-before-processing-hook 'jc-org-publish-project-options)

;; Capture
(setq org-capture-templates
      (quote (
	      ("t" "todo" entry (file+headline "~/org/orgfiles/refile.org" "Tâches") "* TODO  %? %^G\n DEADLINE: %^t" :clock-resume t :kill-buffer t)
	      ("c" "Contacts" entry (file "~/org/orgfiles/contacts.org") "* %(org-contacts-template-name)\n :PROPERTIES: :EMAIL: %(org-contacts-template-email)\n :END:")
	      ("n" "note" entry (file+headline "~/org/orgfiles/refile.org" "Notes") "* %?\n %^C" :clock-resume t)
	      ("a" "courses" checkitem (file+headline "~/org/orgfiles/maison.org" "Courses") "%? %^C")
	      ("e" "À écouter" item (file+headline "~/org/orgfiles/loisirs.org" "À écouter") "%?\n %^C")
	      ("l" "À lire" item (file+headline "~/org/orgfiles/loisirs.org" "À lire") "%?\n %^C")
	      ("s" "CDs à acheter" checkitem (file+headline "~/org/orgfiles/loisirs.org" "CDs à acheter") "%?\n %^C")
	      ("m" "maintenance" entry (filedatetree "~/org/orgfiles/info.org") "* %?")
	      ("b" "bios" item (file+headline "~/org/orgfiles/lycee.org" "Bios") "%?\n %^C")
	      ("T" "test" item (file+headline "~/org/orgfiles/test.org" "Test") " [ ] %?"
	       ))))



(add-hook 'org-mode-hook 'turn-on-auto-fill)
(add-hook 'org-mode-hook 'flyspell-mode)

(setq org-use-speed-commands t)

(setq org-latex-listings 'minted)
(setq org-latex-minted-options
      '(("frame" "lines")
	("fontsize" "\\scriptsize")
	("linenos" "")))

;; ;; Load the org-weather library
;; (add-to-list 'load-path "~/info/emacs/org-weather")
;; (require 'org-weather)
;; ;; Set your location and refresh the data
;; (setq org-weather-location "Orléans,FR")
;; (org-weather-refresh)

;; Raccourcis
(global-set-key (kbd "C-c C-g") (lambda () (interactive) (org-clock-in '(4))))
(global-set-key (kbd "C-c C-h") 'org-clock-out)
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)
(global-set-key "\C-c'" 'org-edit-special)
(define-key global-map "\C-cc" 'org-capture)

(define-key org-mode-map "\C-ct" (lambda () (interactive) (org-end-of-meta-data)))
