;; ~/.emacs.d/JCcalendrier.el -*- mode: lisp-*-

 (add-hook 'calendar-load-hook
              ;; (lambda ()
	   ;;   (calendar-set-date-style 'european))
	   'european-calendar
	      )

(setq calendar-week-start-day 1
      calendar-day-name-array ["Dimanche" "Lundi" "Mardi" "Mercredi"
      "Jeudi" "Vendredi" "Samedi"]
      calendar-month-name-array ["Janvier" "Février" "Mars" "Avril" "Mai"
      "Juin" "Juillet" "Août" "Septembre"
      "Octobre" "Novembre" "Décembre"])

(defvar calendar-day-abbrev-array
  ["dim" "lun" "mar" "mer" "jeu" "ven" "sam"])
(defvar calendar-month-abbrev-array
  ["jan" "fév" "mar" "avr" "mai" "jun"
   "jul" "aou" "sep" "oct" "nov" "déc"])

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
(require 'french-holidays)
(setq calendar-holidays holiday-french-holidays)

(setq calendar-mark-holidays-flag t)
(setq calendar-mark-diary-entries-flag t)
