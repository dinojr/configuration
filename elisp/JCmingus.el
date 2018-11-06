;; ~/.emacs.d/JCmingus.el -*- mode: lisp-*-

(require 'mingus)
(require 'mingus-stays-home)

(autoload 'mingus "mingus-stays-home" t nil)

(setq mingus-stream-alist
 (quote (("france inter" . "http://mp3.live.tv-radio.com/franceinter/all/franceinterhautdebit.mp3"))
))

(setq mingus-stream-alist
      (quote (("somafm-indiepoprocks" . "http://xstream1.somafm.com:8070")
	      ("somafm-bagelradio" . "http://ice.somafm.com/bagel-64.aac")
	      ("franceinter" . "http://mp3.live.tv-radio.com/franceinter/all/franceinterhautdebit.mp3")
	      ("lemouv" . ""))))

(setq mingus-podcast-alist
  (quote (("canteloup" . "http://www.europe1.fr/podcasts/revue-de-presque.xml") 
	  ("collin" . "http://radiofrance-podcast.net/podcast09/rss_12053.xml")
	  ("morin" . "http://radiofrance-podcast.net/podcast09/rss_10906.xml")
	  ("tete au carre" . "http://radiofrance-podcast.net/podcast09/rss_10212.xml")
	  ("masque" . "http://radiofrance-podcast.net/podcast09/rss_14007.xml")
	  ("marque mailhot" . "http://www.rtl.fr/podcast/la-marque-du-mailhot.xml")
	  ("porte" . "http://www.rtl.fr/podcast/a-la-bonne-heure-didier-porte.xml")
	  ("mailhot" . "http://www.rtl.fr/podcast/a-la-bonne-heure-regis-mailhot.xml")))
  )

(add-to-list 'global-mode-string mingus-mode-line-object t)
(setq mingus-mode-line-string-max 100)
;; Raccourcis

(global-set-key "\C-cq" 'mingus-query)
(add-to-list 'helm-completing-read-handlers-alist '(mingus-query . nil))

;; (require 'emms-mode-line-cycle)

;; (emms-mode-line 1)
;; (emms-playing-time 1)

;; ;; If you use this package like `emms-mode-line-icon', you need to load it.
;; (require 'emms-mode-line-icon)
;; (setq emms-mode-line-cycle-use-icon-p t)

;; (emms-mode-line-cycle 1)

(setq mingus-mode-always-modeline nil
      mingus-mode-line-show-status t
      mingus-mode-line-show-volume nil
      mingus-mode-line-show-elapsed-time nil
      mingus-mode-line-show-consume-and-single-status nil)

(defun jc-mingus-set-frame-title ()
  (interactive)
  (setq frame-title-format (mingus-make-mode-line-string))
  (setq icon-title-format (mingus-make-mode-line-string))
  )

(add-hook 'mingus-playlist-hooks '(lambda () run-with-timer 0 10 'jc-mingus-set-frame-title))

(setq mingus-mode-line-separator
        (if 'display-graphic-p
             " 🎸 "
          " + "))

