;; ~/.emacs.d/JCorgcaldav.el -*- mode: lisp-*-
(require 'org-caldav)
(setq org-caldav-url "https://www.google.com/calendar/dav")
(setq org-caldav-calendar-id "09qqpld5o29tddmmv92dse1tng@group.calendar.google.com")
(setq org-caldav-inbox "~/org/org-caldav.org")
(setq org-caldav-files '("~/org/orgfiles/planning.org"))
(setq org-icalendar-timezone "Europe/Paris")

(org-caldav-sync)
