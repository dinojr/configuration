;; ~/.emacs.d/JCcalfw.el -*- mode: emacs-lisp-*-
;; (add-to-list 'load-path "~/git-repositories/emacs-calfw/")
(use-package calfw)
(use-package calfw-org)
(use-package calfw-ical)
(use-package calfw-gcal)
(use-package calfw-cal)
(setq cfw:fchar-junction ?╋
      cfw:fchar-vertical-line ?┃
      cfw:fchar-horizontal-line ?━
      cfw:fchar-left-junction ?┣
      cfw:fchar-right-junction ?┫
      cfw:fchar-top-junction ?┯
      cfw:fchar-top-left-corner ?┏
      cfw:fchar-top-right-corner ?┓)

;; (cfw:open-ical-calendar "https://www.google.com/calendar/ical/09qqpld5o29tddmmv92dse1tng%40group.calendar.google.com/public/basic.ics")

;; Devoir MPSI2 (cfw:open-ical-calendar "https://calendar.google.com/calendar/ical/5mh6aieegm0e22hij1ih71efg8%40group.calendar.google.com/public/basic.ics")

(setq MPSI2-ical "https://www.google.com/calendar/ical/09qqpld5o29tddmmv92dse1tng%40group.calendar.google.com/public/basic.ics"
      educ-B-ical "https://calendar.google.com/calendar/ical/bubn5utkn054pluh4v44nu6ok62e1dbo%40import.calendar.google.com/public/basic.ics"
      educ-C-ical "https://calendar.google.com/calendar/ical/bubn5utkn054pluh4v44nu6ok62e1dbo%40import.calendar.google.com/public/basic.ics"
      DS-ical "https://calendar.google.com/calendar/ical/5mh6aieegm0e22hij1ih71efg8%40group.calendar.google.com/public/basic.ics"
 )

(setq cfw-cal-list
      (
       list
       (cfw:org-create-source "CornflowerBlue")  ; orgmode source
       (cfw:cal-create-source "Orange") ; diary source
       (cfw:ical-create-source "MPSI2" MPSI2-ical  "IndianRed")
       (cfw:ical-create-source "B" educ-B-ical "Blue")
       (cfw:ical-create-source "C" educ-C-ical "Green")
       (cfw:ical-create-source "DS" DS-ical "Yellow")
       (cfw:ical-create-source "Fériés" "https://calendar.google.com/calendar/ical/fr.french%23holiday%40group.v.calendar.google.com/public/basic.ics" "Green")
       (cfw:ical-create-source "Fam" "https://calendar.google.com/calendar/ical/fh0o4m68o252290ovr7voe3584%40group.calendar.google.com/public/basic.ics" "Sienna")
       (cfw:ical-create-source "Enf" "https://calendar.google.com/calendar/ical/8shtsmesiu1cbvt8dudajk0a8s%40group.calendar.google.com/public/basic.ics" "Sienna3")
       (cfw:ical-create-source "Perso" "https://calendar.google.com/calendar/ical/j.cubizolles%40gmail.com/private-f6abd3bad0757d85bc3968a56d86fce7/basic.ics" "DarkCyan")
       ;; (cfw:howm-create-source "Blue")  ; howm source
    ;; (cfw:ical-create-source "Moon" "~/moon.ics" "Gray")  ; ICS source1
    ;; (cfw:ical-create-source "gcal" "https://..../basic.ics" "IndianRed") ; google calendar ICS
   ))

(defun jc-open-calendar ()
  (interactive)
  (cfw:open-calendar-buffer
   :contents-sources
   cfw-cal-list
   ))

;; + Faire une liste de variables-toggles passée en arguments à une
;; fonction jc-make-cfw-cal-list pour créer cfw-cal-list en ajoutant ou
;; supprimant une source dans cfw-cal-list

;; + Faire rajouter des keys pour déclencher le changement du toggle et
;; le redraw pour chaque agenda
