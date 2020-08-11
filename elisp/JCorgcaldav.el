;; ~/.emacs.d/JCorgcaldav.el -*- mode: emacs-lisp-*-
;; (require 'package) ;; org-caldav is loaded through melpa
;; (package-initialize)

(add-to-list 'load-path "~/git-repositories/org-mode/lisp") ;; running org-mode from git
(add-to-list 'load-path "~/git-repositories/org-mode/contrib/lisp")
(require 'org)
(require 'org-caldav)

(setq org-caldav-url 'google)

;; Projet Org-mode créé sur https://console.developers.google.com/projectselector/apis/credentials
;; Il faut aussi, dans "Tableau de bord", activer l'API CalDAV
(setq org-caldav-oauth2-client-id "760965627563-fsbk1a5kddifiv5clrncuahdcc1n6tlc.apps.googleusercontent.com")
(setq org-caldav-oauth2-client-secret "6eJFJObg_C4v7K4_dfEQCnDS")
;; (setq org-caldav-calendar-id "09qqpld5o29tddmmv92dse1tng@group.calendar.google.com")
(setq org-caldav-calendar-id "mfuh5b8oh2oqd9ilu89hsap6fk@group.calendar.google.com")

(setq plstore-cache-passphrase-for-symmetric-encryption t)

(setq org-caldav-inbox "~/org/org-caldav.org")
(setq org-caldav-files '("~/org/orgfiles/planning-20-21.org" "~/org/orgfiles/lycee-20-21.org"))
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

;; org-property-action -> delete globally ID property pour tout
;; remettre à plat en cas de problème

;; (add-to-list 'load-path "~/git-repositories/org-mode/lisp")
;; (add-to-list 'load-path "~/git-repositories/org-mode/contrib/lisp")
;; (load "/home/wilk/.emacs.d/elpa/org-caldav-20160614.1342/org-caldav.el")
;; (load "/home/wilk/configuration/elisp/JCorgcaldav.el")


(global-set-key [f5] 'org-caldav-sync)


;; Il ne faut pas lancer org-caldav-sync depuis un emacsclient sinon
;; le pinentry ne peut pas se lancer
