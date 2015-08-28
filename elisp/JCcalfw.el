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

(defun jc-cfw-open-planning-calendar ()
  (interactive)
  (let ((org-agenda-files '("~/org/orgfiles/planning.org")))
  (cfw:open-org-calendar)))

