;; ~/.emacs.d/JCorgcaldav-test.el -*- mode: lisp-*-
(require 'org-caldav)
(setq org-caldav-url "https://www.google.com/calendar/dav")
(setq org-caldav-calendar-id "4noetgnqqu1hq6gpam4pnpr7m8@group.calendar.google.com")


(setq org-caldav-inbox "~/org/org-caldav-test.org")
(setq org-caldav-files '( "~/org/orgfiles/test-orgcaldav.org"))
(setq org-icalendar-timezone "Europe/Paris")
(setq org-caldav-save-directory "~/org/") ; to ensure synchronization by unison


;; org-property-action -> delete globally ID property pour tout
;; remettre à plat en cas de problème

;; (add-to-list 'load-path "~/git-repositories/org-mode/lisp")
;; (add-to-list 'load-path "~/git-repositories/org-mode/contrib/lisp")
;; (load "/home/wilk/.emacs.d/elpa/org-caldav-20160614.1342/org-caldav.el")
;; (load "/home/wilk/configuration/elisp/JCorgcaldav.el")


(global-set-key [f5] 'org-caldav-sync)
