;; ~/.emacs.d/JCcalfw.el -*- mode: lisp-*-

(require 'calfw)
(require 'calfw-org)
(require 'calfw-ical)
(require 'calfw-cal)
(setq cfw:fchar-junction ?╋
      cfw:fchar-vertical-line ?┃
      cfw:fchar-horizontal-line ?━
      cfw:fchar-left-junction ?┣
      cfw:fchar-right-junction ?┫
      cfw:fchar-top-junction ?┯
      cfw:fchar-top-left-corner ?┏
      cfw:fchar-top-right-corner ?┓)

;; (cfw:open-ical-calendar "https://www.google.com/calendar/ical/09qqpld5o29tddmmv92dse1tng%40group.calendar.google.com/public/basic.ics")

(defun jc-change-agenda-files ()
  (make-local-variable 'org-agenda-files)
  (setq org-agenda-files '("~/org/orgfiles/planning.org")))

(jc-change-agenda-files)

(advice-add 'cfw:open-org-calendar :before
	      'jc-change-agenda-files)
