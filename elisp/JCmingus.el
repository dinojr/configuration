;; ~/.emacs.d/JCmingus.el -*- mode: lisp-*-

(add-to-list 'load-path "/home/wilk/.emacs.d/mingus/")

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


;; Raccourcis

(global-set-key "\C-cq" 'mingus-query)
