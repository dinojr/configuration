;; ~/.emacs.d/JCorgcaldav.el -*- mode: lisp-*-
(require 'org-caldav)
(setq org-caldav-url "https://www.google.com/calendar/dav")
(setq org-caldav-calendar-id "09qqpld5o29tddmmv92dse1tng@group.calendar.google.com")
(setq org-caldav-inbox "~/org/org-caldav.org")
(setq org-caldav-files '("~/org/orgfiles/planning.org" "~/org/orgfiles/lycee-15-16.org"))
(setq org-icalendar-timezone "Europe/Paris")
(setq org-caldav-save-directory "~/org/") ; to ensure synchronization by unison
;; Fonction pour créer plein d'entrées 
;; #+begin_src emacs-lisp :results raw
;; (with-temp-buffer
;; (insert "*** TP
;; <2015-09-04 ven 08:00-12:00>")
;; (goto-char (point-min))
;; (org-clone-subtree-with-time-shift 30 "+1w")
;; ;; ignore this
;; (let ((str (buffer-string)))
;; (set-text-properties 0 (length str) nil str) str))
;; #+end_src
;; #+RESULTS:

;; (org-caldav-sync)

(global-set-key [f5] 'org-caldav-sync)
