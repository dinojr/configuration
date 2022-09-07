;; ~/emacs.d/JCorg.el -*- mode: emacs-lisp-*-

;; Uncomment to load from git
(add-to-list 'load-path "~/git-repositories/org-mode/lisp")
(add-to-list 'load-path "~/git-repositories/org-contrib/lisp")

(with-eval-after-load 'info
  (add-to-list 'Info-directory-list "~/git-repositories/org-mode/doc/")
  )

(setq org-modules (quote (ol-w3m ol-bbdb ol-bibtex ol-docview ol-gnus ol-info ol-irc ol-mhe ol-rmail ol-eww drill)))
(eval-after-load 'org
  '(org-load-modules-maybe t))

(setq org-clock-x11idle-program-name
      (pcase (getenv "XDG_SESSION_TYPE")
	("x11" "xprintidle")
	("wayland" "jc-wayland-idle-time")
      ))

(require 'org)

(require 'notifications)

(setq org-export-backends '(ascii html icalendar latex beamer odt))
(with-eval-after-load "ox"
  (setq org-export-in-background t))


(set-face-attribute 'org-level-1 nil :height 1.0)
(set-face-attribute 'org-level-2 nil :height 1.0)
(set-face-attribute 'org-level-3 nil :height 1.0)

(add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))

;; (setq org-insert-todo-heading-respect-content t)
;; (setq org-insert-heading-respect-content t)
(setq org-src-fontify-natively t)

(setq org-special-ctrl-a/e t)

(setq org-startup-indented t)
(setq org-hide-leading-stars t)

;; (add-to-list 'load-path "~/git-repositories/org-bullets")
;; (require 'org-bullets)
;; (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)(org-indent-mode 1)))

(require 'org-superstar)
(add-hook 'org-mode-hook (lambda () (org-superstar-mode 1) (org-indent-mode 1)))


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

(setq org-agenda-time-grid '((daily today)
 (800 1000 1200 1400 1600 1800 2000)
 "......" "----------------"))
;; Org-caldav
;; installé manuellement dans les répertoires de ~/info/emacs/org... à déplacer maintenant que org est avec melpa
;; (require 'org-caldav)
;; (setq org-caldav-url "https://www.google.com/calendar/dav")
;; (setq org-caldav-calendar-id "0fseo5jbfp99polnfc6ic38h88@group.calendar.google.com")
;; (setq org-caldav-inbox "~/org/org-caldav.org")
;; (setq org-caldav-files (quote ("~/org/orgfiles/maison.org" "~/org/orgfiles/vuibert.org" "~/org/orgfiles/lycee.org" "~/org/orgfiles/science.org" "~/org/orgfiles/loisirs.org" "~/org/orgfiles/info.org" "~/org/orgfiles/famille.org")))
;; (setq org-icalendar-timezone "Europe/Paris")

;; Export to ipynb notebooks
(add-to-list 'load-path "~/git-repositories/ox-ipynb")
(require 'ox-ipynb)

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
   (ipython . t)
   (ruby . t)
   (screen . nil)
   (shell . t)
   (sql . nil)
   (sqlite . t)
   (lilypond . t)))
;; ou
;; (require 'ob-calc)

; Refiling
; Use IDO for target completion
;; (setq org-completion-use-ido t)
; Targets include this file and any file contributing to the agenda - up to 5 levels deep
(setq org-refile-targets (quote ((org-agenda-files :maxlevel . 5) (nil :maxlevel . 5))))
; Targets start with the file name - allows creating level 1 tasks
(setq org-refile-use-outline-path (quote file))
; Targets complete in steps so we start with filename, TAB shows the next level of targets etc
(setq org-outline-path-complete-in-steps nil)
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
 ("CANCELED" :foreground "yellow green" :weight bold)
 ("BUG" :foreground "red1" :weight bold)
 ("REPORTED" :foreground "slate blue" :weight bold)
 ("FIXED" :foreground "yellow green" :weight bold)
 ("WONTFIX" :foreground "yellow green" :weight bold)
)))

(setq org-todo-keywords
      '((sequence "TODO(t)" "STARTED(s!)" "WAITING(w@/!)" "|" "DONE(d!)" "CANCELED(c@)")
	(sequence "BUG(b!)" "REPORT(r@)" "KNOWNCAUSE(k@)" "|" "FIXED(f!)")
	(sequence "SOMEDAY(S)" "|" "CANCELED(c@)" "DONE(d!)")))

;Clocking
;;
(setq org-agenda-clockreport-parameter-plist (quote (:link t :maxlevel 4)))
;; Keep clocks running
;(setq org-remember-clock-out-on-exit nil)
;; Resume clocking tasks when emacs is restarted
(org-clock-persistence-insinuate)
(add-hook 'org-clock-in-hook 'org-clock-save)
(add-hook 'org-clock-out-hook 'org-clock-save)
;; Yes it's long... but more is better ;)
(setq org-clock-history-length 10)
;; Resume clocking task on clock-in if the clock is open
(setq org-clock-in-resume t)
;; Do not prompt to resume an active clock
;(setq org-clock-persist-query-resume nil)
;; Save the running clock and all clock history when exiting Emacs, load it on startup
(setq org-clock-persist t)

(setq org-clock-idle-time 10)

(setq org-clock-mode-line-total 'today)

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
;; (setq org-clock-persist (quote history))
;; Disable auto clock resolution
(setq org-clock-auto-clock-resolution nil)
;; Remove empty CLOCK drawers on clock out
(defun jc/remove-empty-drawer-on-clock-out ()
  (interactive)
  (save-excursion
    (beginning-of-line 0)
    (org-remove-empty-drawer-at "CLOCK" (point))))

;; (add-hook 'org-clock-out-hook 'jc/remove-empty-drawer-on-clock-out 'append)

(defun jc-org-clock-remove-old-clock-entries (n)
  "Remove clock entries whose end is older than N weeks in current subtree.
Skip over dangling clock entries."
  (interactive "nnumber of weeks: ")
  (save-excursion
    (org-back-to-heading t)
    (org-map-tree
     (lambda ()
       (let ((drawer (re-search-forward org-clock-drawer-start-re (save-excursion (org-end-of-subtree)) t))
	     (case-fold-search t))
	 (when drawer
	   (let ((re org-clock-line-re)
		 (end (save-excursion (re-search-forward org-clock-drawer-end-re (save-excursion (org-end-of-subtree)) nil)))
		 )
	     (while (re-search-forward re end t)
	       (skip-chars-forward " \t\r")
	       (looking-at org-tr-regexp-both)
	       (when (>= (/ (time-to-number-of-days (org-time-since (match-string-no-properties 2))) 7) (float n)) (kill-whole-line))
	       ))))))
    (org-clock-remove-empty-clock-drawer)
    ))

(require 'org-mru-clock)
(setq org-mru-clock-how-many 20)
(setq org-mru-clock-completing-read #'helm--completing-read-default)
(setq org-mru-clock-keep-formatting t)
(setq org-mru-clock-files #'org-agenda-files)

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
                            ("CANCELED" . ?C))))

(setq org-todo-state-tags-triggers
      (quote (("CANCELED" ("CANCELED" . t))
              ("WAITING" ("WAITING" . t) ("NEXT"))
	      ("REPORTED" ("WAITING" . t) ("NEXT"))
              (done ("NEXT") ("WAITING"))
              ("TODO" ("WAITING") ("CANCELED") ("NEXT"))
              ("STARTED" ("WAITING"))
              ("DONE" ("WAITING") ("CANCELED") ("NEXT")))))


(advice-add 'org-revert-all-org-buffers :after #'org-clock-load)
(advice-add 'org-save-all-org-buffers :after #'org-clock-save)

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
(add-hook 'org-agenda-mode-hook #'(lambda () (hl-line-mode 1)))
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
	      ("O" "Tâches orphelines" alltodo "" ((org-agenda-todo-ignore-timestamp  (quote all))))
	      ("wt" "Boulot" tags-todo "enseignement"
	       ((org-agenda-overriding-header "Boulot à programmer")
		(org-agenda-todo-ignore-with-date nil)
		)
					;((org-agenda-filter-preset '("+lycée")))
	       ;; ("~/tmp/lycee.pdf")
	       )
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
		(tags-todo "@girodet"))
	       ;; ((org-agenda-filter-preset '("+GIRODET")))
	       ;; ("~/tmp/girodet.pdf")
	       )
	      ("wp" "Agenda et tâches pour Paris"
	       ((agenda "Paris"
		((org-agenda-entry-types '(:timestamp))))
		(tags-todo "@colombier")
		(tags-todo "@versailles")
		(tags-todo "@brissac"))
	       ;; ((org-agenda-filter-preset '("+GIRODET")))
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
	      ;; ("K" "Canceled Tasks" todo "CANCELED" ((org-agenda-todo-ignore-scheduled nil)
              ;;                                      (org-agenda-todo-ignore-deadlines nil)
              ;;                                      (org-agenda-todo-ignore-with-date nil)))
; 	      ("O" "Tâches orphelines" alltodo "" ((org-agenda-todo-ignore-timestamp  (quote all))))
	      ;; ("O" "Tâches orphelines" alltodo "" ((org-agenda-todo-ignore-with-date t)))
              ;; ("W" "Tasks waiting on something" tags "WAITING/!" ((org-use-tag-inheritance nil)
              ;;                                                     (org-agenda-todo-ignore-with-date nil)
              ;;                                                     (org-agenda-todo-ignore-deadlines nil)
              ;;                                                     (org-agenda-todo-ignore-scheduled nil)))
              ("R" "Refile New Notes and Tasks" tags "LEVEL=2+REFILE" ((org-agenda-todo-ignore-with-date nil)
                                                                       (org-agenda-todo-ignore-deadlines nil)
                                                                       (org-agenda-todo-ignore-scheduled nil)))
	      ("V" "Review projects" tags-todo "-CANCELLED/"
	       ((org-agenda-overriding-header "Reviews Scheduled")
		(org-agenda-skip-function 'org-review-agenda-skip)
		(org-agenda-cmp-user-defined 'org-review-compare)
		;; (org-agenda-sorting-strategy '(user-defined-down))
		))
              ;; ("N" "Notes" tags "NOTE" nil)
              ;; ("n" "Next" tags "NEXT-WAITING-CANCELED/!" nil)
              ;; ("P" "Projects" tags-todo "project-WAITING-CANCELED/!-DONE" nil)
              ;; ("wc" "Temps de cerveau..." tags "LEVEL>2+lire|LEVEL>2+ecouter|LEVEL>=2+voir" nil)
              ;; ("A" "Tasks to be Archived" tags "LEVEL=2/DONE|CANCELED" nil)
              ;; ("H" "Habits" tags "STYLE=\"habit\""
	      ;;  ((org-agenda-todo-ignore-with-date nil)
	      ;; 	(org-agenda-todo-ignore-scheduled nil)
	      ;; 	(org-agenda-todo-ignore-deadlines nil)))
	      )))



(setq org-stuck-projects (quote ("projet/!-DONE-CANCELED" nil ("NEXT") "")))

; Enable habit tracking (and a bunch of other modules)
;; (setq org-modules (quote (ol-w3m ol-bbdb ol-bibtex ol-docview ol-gnus ol-info ol-irc ol-mhe ol-rmail ol-eww org-drill)))
(setq org-modules (quote (ol-w3m ol-bbdb ol-bibtex ol-docview ol-gnus ol-info ol-irc ol-mhe ol-rmail ol-eww)))

; global STYLE property values for completion
(setq org-global-properties (quote (("STYLE_ALL" . "habit"))))
; position the habit graph on the agenda to the right of the default
(setq org-habit-graph-column 50)
(run-at-time "08:00" 86400 #'(lambda () (setq org-habit-show-habits t)))

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

(with-eval-after-load 'ox-latex
  (add-to-list 'org-latex-classes
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
  )
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

(setq org-latex-pdf-process '("latexmk -pdflua -shell-escape -bibtex -f %f"))

(setq org-export-allow-bind-keywords t)

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
	(rename-file file-pdf-name file-suffix-pdf-name 1)
	)
      )
    )

(defun jc-org-publish-rename (suffix version)
    "Rename file.suffix to file-version.suffix when buffer is visiting file.org"
    (let*   ((file-base-name (remove-org-suffix (buffer-file-name)))
	     (file-suffix-name (concat file-base-name "." suffix))
	     (file-version-suffix-name (concat file-base-name "-" version  "." suffix)))
    (when (file-exists-p file-suffix-name)
	(rename-file file-suffix-name file-version-suffix-name t)
	;; (if (equal suffix "pdf")
	;;     (org-open-file file-version-suffix-name))
	)
    )
    )


(defun jc-org-publish-rename-notes-pdf (project-list)
  "Rename file.pdf to file-notes.pdf and file.tex to file-notes.tex when buffer is visiting file.org"
  (jc-org-publish-rename '"pdf" '"notes")
  (jc-org-publish-rename '"tex" '"notes"))

(defun jc-org-publish-rename-eleves-pdf (project-list)
  "Rename file.pdf to file-eleves.pdf and file.tex to file-eleves.tex when buffer is visiting file.org"
  ;; (jc-org-publish-rename-pdf '"eleves")
  (jc-org-publish-rename '"pdf" '"eleves")
  (jc-org-publish-rename '"tex" '"eleves")
  )

(defun jc-org-publish-rename-beamer-pdf (project-list)
  "Rename file.pdf to file-beamer.pdf and file.tex to file-beamer.tex when buffer is visiting file.org"
  (jc-org-publish-rename '"pdf" '"beamer")
  (jc-org-publish-rename '"tex" '"beamer"))

(defun jc-org-latex-notes-preparation (project-list)
  "Preparation functions to be run before actually pubishing"
  ;; (progn (setq org-latex-title-command "")
  ;;   (org-latex-publish-to-pdf))
  (setq org-latex-title-command "")
  )

(defun jc-notify-end-compilation-eleves (project-list)
  (let* ((file-name (remove-org-suffix (file-name-nondirectory buffer-file-name))))
      (notifications-notify
       :title file-name
       :body "élèves"
       )
      ))

(defun jc-notify-end-compilation-notes (project-list)
  (let* ((file-name (remove-org-suffix (file-name-nondirectory buffer-file-name))))
      (notifications-notify
       :title file-name
       :body "notes"
   )
  ))

(defun jc-notify-end-compilation-beamer (project-list)
  (let* ((file-name (remove-org-suffix (file-name-nondirectory buffer-file-name))))
      (notifications-notify
       :title file-name
       :body "beamer"
   )
  ))


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
	      ("r" "refile")
	      ("rt" "todo travail" entry (file+headline "~/org/orgfiles/refile.org" "Tâches travail") "* TODO  %? %^G\n DEADLINE: %^t" :clock-resume t :kill-buffer t)
	      ("ri" "todo info" entry (file+headline "~/org/orgfiles/refile.org" "Tâches info") "* TODO  %? %^G\n DEADLINE: %^t" :clock-resume t :kill-buffer t)
	      ("c" "Contacts" entry (file "~/org/orgfiles/contacts.org") "* %(org-contacts-template-name)\n :PROPERTIES: :EMAIL: %(org-contacts-template-email)\n :END:")
	      ("n" "note" entry (file+headline "~/org/orgfiles/refile.org" "Notes") "* %?\n %^C" :clock-resume t)
	      ("a" "courses" checkitem (file+headline "~/org/orgfiles/maison.org" "Courses") "%? %^C")
	      ("e" "À écouter" item (file+headline "~/org/orgfiles/loisirs.org" "À écouter") "%?\n %^C")
	      ("l" "À lire" item (file+headline "~/org/orgfiles/loisirs.org" "À lire") "%?\n %^C")
	      ("v" "À voir" item (file+headline "~/org/orgfiles/loisirs.org" "À voir") "%?\n %u\n %^C")
	      ("s" "CDs à acheter" checkitem (file+headline "~/org/orgfiles/loisirs.org" "CDs à acheter") "%?\n %^C")
	      ("m" "maintenance")
	      ("mi" "maintenance info" entry (file+olp+datetree "~/org/orgfiles/info.org") "* %?")
	      ("md" "maintenance domestique" entry (file+olp+datetree "~/org/orgfiles/maison.org") "* %?")
	      ("S" "Santé" entry (file+olp+datetree "~/org/orgfiles/sante.org" "Chronologie") "* %?")
	      ("b" "bios" item (file+headline "~/org/orgfiles/lycee.org" "Bios") "%?\n %^C")
	      ("p" "password" entry (file "~/org/orgfiles/pw.gpg") "* %^{Title}\n  %^{URL}p %^{USERNAME}p %^{PASSWORD}p")
	      )))



(add-hook 'org-mode-hook 'turn-on-auto-fill)
(add-hook 'org-mode-hook 'flyspell-mode)

(setq org-use-speed-commands t)

(setq org-latex-listings 'minted)
(setq org-latex-minted-options
      '(("frame" "lines")
	("fontsize" "\\scriptsize")
	("linenos" "")))

;; Allow to use a) instead of 1) in ordered lists
;; (setq org-list-allow-alphabetical t)
;; (org-element-update-syntax)

(defun org-repair-export-blocks ()
  "Repair export blocks and INCLUDE keywords in current buffer."
  (interactive)
  (when (eq major-mode 'org-mode)
    (let ((case-fold-search t)
	  (back-end-re (regexp-opt
			'("HTML" "ASCII" "LATEX" "ODT" "MARKDOWN" "MD" "ORG"
			  "MAN" "BEAMER" "TEXINFO" "GROFF" "KOMA-LETTER")
			t)))
      (org-with-wide-buffer
       (goto-char (point-min))
       (let ((block-re (concat "^[ \t]*#\\+BEGIN_" back-end-re)))
	 (save-excursion
	   (while (re-search-forward block-re nil t)
	     (let ((element (save-match-data (org-element-at-point))))
	       (when (eq (org-element-type element) 'special-block)
		 (save-excursion
		   (goto-char (org-element-property :end element))
		   (save-match-data (search-backward "_"))
		   (forward-char)
		   (insert "EXPORT")
		   (delete-region (point) (line-end-position)))
		 (replace-match "EXPORT \\1" nil nil nil 1))))))
       (let ((include-re
	      (format "^[ \t]*#\\+INCLUDE: .*?%s[ \t]*$" back-end-re)))
	 (while (re-search-forward include-re nil t)
	   (let ((element (save-match-data (org-element-at-point))))
	     (when (and (eq (org-element-type element) 'keyword)
			(string= (org-element-property :key element) 
				 "INCLUDE"))
	       (replace-match "EXPORT \\1" nil nil nil 1)))))))))

(defun org-repair-property-drawers ()
  "Fix properties drawers in current buffer.
 Ignore non Org buffers."
  (interactive)
  (when (eq major-mode 'org-mode)
    (org-with-wide-buffer
     (goto-char (point-min))
     (let ((case-fold-search t)
           (inline-re (and (featurep 'org-inlinetask)
                           (concat (org-inlinetask-outline-regexp)
                                   "END[ \t]*$"))))
       (org-map-entries
        (lambda ()
          (unless (and inline-re (org-looking-at-p inline-re))
            (save-excursion
              (let ((end (save-excursion (outline-next-heading) (point))))
                (forward-line)
                (when (org-looking-at-p org-planning-line-re) (forward-line))
                (when (and (< (point) end)
                           (not (org-looking-at-p org-property-drawer-re))
                           (save-excursion
                             (and (re-search-forward org-property-drawer-re end t)
                                  (eq (org-element-type
                                       (save-match-data (org-element-at-point)))
                                      'drawer))))
                  (insert (delete-and-extract-region
                           (match-beginning 0)
                           (min (1+ (match-end 0)) end)))
                  (unless (bolp) (insert "\n"))))))))))))

;; ;; Load the org-weather library
;; (add-to-list 'load-path "~/info/emacs/org-weather")
;; (require 'org-weather)
;; ;; Set your location and refresh the data
;; (setq org-weather-location "Orléans,FR")
;; (org-weather-refresh)

;; Org-passwords
(add-to-list 'load-path "~/git-repositories/org-passwords.el/.")
(require 'org-passwords)
(setq org-passwords-file "~/org/orgfiles/pw.gpg")
(setq org-passwords-random-words-dictionnary "/etc/dictionaries-common/words")

;; org-ref
(require 'org-ref)
(require 'org-ref-pdf)
(require 'org-ref-url-utils)
(require 'org-ref-arxiv)

(setq org-ref-pdf-directory "~/enseignement/papiers")
(setq org-ref-bibtex-files "~/enseignement/papiers/bibliography.bib")

(require 'org-checklist) ; pour mettre à 0 les checkboxes quand une tâche est passée en DONE

(require 'org-review); pour mettre des review sur une tâche
(setq org-review-delay "+3d")

;; Sci-hub
(defun sci-hub-pdf-url (doi)
  "Get url to the pdf from SCI-HUB"
  (setq *doi-utils-pdf-url* (concat "https://sci-hub.hkvisa.net/" doi) ;captcha
        *doi-utils-waiting* t
        )
  ;; try to find PDF url (if it exists)
  (url-retrieve (concat "https://sci-hub.se/" doi)
            (lambda (status)
              (goto-char (point-min))
              (while (search-forward-regexp "\\(https://\\|//sci-hub.hkvisa.net/downloads\\).+download=true'" nil t)
                (let ((foundurl (match-string 0)))
                  (message foundurl)
                  (if (string-match "https:" foundurl)
                  (setq *doi-utils-pdf-url* foundurl)
                (setq *doi-utils-pdf-url* (concat "https:" foundurl))))
                (setq *doi-utils-waiting* nil))))
  (while *doi-utils-waiting* (sleep-for 0.1))
  *doi-utils-pdf-url*)

(defun doi-utils-get-bibtex-entry-pdf (&optional arg)
    "Download pdf for entry at point if the pdf does not already exist locally.
The entry must have a doi. The pdf will be saved to
`org-ref-pdf-directory', by the name %s.pdf where %s is the
bibtex label.  Files will not be overwritten.  The pdf will be
checked to make sure it is a pdf, and not some html failure
page. You must have permission to access the pdf. We open the pdf
at the end if `doi-utils-open-pdf-after-download' is non-nil.

With one prefix ARG, directly get the pdf from a file (through
`read-file-name') instead of looking up a DOI. With a double
prefix ARG, directly get the pdf from an open buffer (through
`read-buffer-to-switch') instead. These two alternative methods
work even if the entry has no DOI, and the pdf file is not
checked."
    (interactive "P")
    (save-excursion
      (bibtex-beginning-of-entry)
      (let ( ;; get doi, removing http://dx.doi.org/ if it is there.
        (doi (replace-regexp-in-string
          "https?://\\(dx.\\)?.doi.org/" ""
          (bibtex-autokey-get-field "doi")))
        (key (cdr (assoc "=key=" (bibtex-parse-entry))))
        (pdf-url)
        (pdf-file))
    (setq pdf-file (concat
            (if org-ref-pdf-directory
                (file-name-as-directory org-ref-pdf-directory)
              (read-directory-name "PDF directory: " "."))
            key ".pdf"))
    ;; now get file if needed.
    (unless (file-exists-p pdf-file)
      (cond
       ((and (not arg)
         doi
         (if (doi-utils-get-pdf-url doi)
             (setq pdf-url (doi-utils-get-pdf-url doi))
           (setq pdf-url "https://www.sciencedirect.com/science/article/")))
        (url-copy-file pdf-url pdf-file)        
        ;; now check if we got a pdf
        (if (org-ref-pdf-p pdf-file)
        (message "%s saved" pdf-file)
          (delete-file pdf-file)
          ;; sci-hub fallback option
          (setq pdf-url (sci-hub-pdf-url doi))
          (url-copy-file pdf-url pdf-file)
          ;; now check if we got a pdf
          (if (org-ref-pdf-p pdf-file)
          (message "%s saved" pdf-file)
        (delete-file pdf-file)
        (message "No pdf was downloaded.") ; SH captcha
        (browse-url pdf-url))))
       ;; End of sci-hub fallback option
       ((equal arg '(4))
        (copy-file (expand-file-name (read-file-name "Pdf file: " nil nil t))
               pdf-file))
       ((equal arg '(16))
        (with-current-buffer (read-buffer-to-switch "Pdf buffer: ")
          (write-file pdf-file)))
       (t
        (message "We don't have a recipe for this journal.")))
      (when (and doi-utils-open-pdf-after-download (file-exists-p pdf-file))
        (org-open-file pdf-file))))))



;; Raccourcis
(global-set-key (kbd "C-c C-g") (lambda () (interactive) (org-clock-in '(4))))
(global-set-key (kbd "C-c C-h") 'org-clock-out)
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-switchb)
(global-set-key "\C-c'" 'org-edit-special)
(define-key global-map "\C-cc" 'org-capture)

(defun jc-current-line-empty-p ()
  (interactive)
  (save-excursion
    (beginning-of-line)
    (looking-at "[[:space:]]*$")))

(defun kolourpaint-open (path)
  "Open the path in kolourpaint"
  (interactive)
  (unless (f-ext-p path "png") (error "Must be an png file."))
  ;; (unless (file-exists-p path)
  ;;   (with-temp-file path
  ;;     (insert template-svg)))
  (shell-command (format "kolourpaint %s &" path)))

(org-link-set-parameters
 "file"
 :follow (lambda (path)
    	   (let ((actions '(("find-file" . find-file)
    			    ("edit in kolourpaint" . kolourpaint-open))))
    	     (funcall (cdr (assoc (completing-read "Action: " actions) actions)) path))))

(eval-after-load 'ox '(require 'ox-koma-letter))
(eval-after-load 'ox-koma-letter
  '(progn
     (add-to-list 'org-latex-classes
                  '("my-letter"
                    "\\documentclass\{scrlttr2\}
     \\usepackage[frenchb]{babel}
     \\LoadLetterOption{NF}
\\RequirePackage{polyglossia}
\\setdefaultlanguage{french}
\\RequirePackage{fontspec}
\\setmainfont{TeX Gyre Pagella}
\\setsansfont{Libertinus Sans}
\\defaultfontfeatures{ligatures = TeX}
")
		  )

     (setq org-koma-letter-default-class "my-letter")))

(define-key org-mode-map "\C-ct" (lambda ()
				   (interactive)
				   (org-end-of-meta-data)
				   (if (not (jc-current-line-empty-p))
				       (open-line 1)
				     )))

(define-key org-mode-map "\C-cy" (lambda ()
				   (interactive)
				   (org-beginning-of-line)
				   (org-yank)
				   (unfill-paragraph)
				   (mark-paragraph)
				   ))

(org-defkey org-mode-map "\C-c\C-w" 'helm-org-agenda-files-headings)

(add-hook 'org-agenda-mode-hook
          (lambda ()
            (local-set-key (kbd "C-c C-r")
                           'org-review-insert-last-review)))

(global-set-key (kbd "<f9>") 'org-agenda)

(org-defkey org-mode-map "\C-c;" 'org-time-stamp-inactive)

(require 'org-duration)
