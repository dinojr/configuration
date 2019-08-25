;; ~/.emacs.d/JCpodcaster.el -*- mode: emacs-lisp-*-

(require 'podcaster)
(setq podcaster-feeds-urls
      '("http://radiofrance-podcast.net/podcast09/rss_10212.xml"
	"http://radiofrance-podcast.net/podcast09/rss_14007.xml"
	"http://radiofrance-podcast.net/podcast09/rss_10906.xml"
	"http://cdn-europe1.new2.ladmedia.fr/var/exports/podcasts"
	"http://radiofrance-podcast.net/podcast09/rss_14322.xml"
	"http://radiofrance-podcast.net/podcast09/rss_14312.xml"
	"http://radiofrance-podcast.net/podcast09/rss_18141.xml"
	"http://radiofrance-podcast.net/podcast09/rss_13129.xml"
	"http://radiofrance-podcast.net/podcast09/rss_13158.xml"
	"http://radiofrance-podcast.net/podcast09/rss_14215.xml"
	"http://radiofrance-podcast.net/podcast09/rss_14321.xml"
	"http://radiofrance-podcast.net/podcast09/rss_19581.xml"
	"http://radiofrance-podcast.net/podcast09/rss_13364.xml"
	"http://radiofrance-podcast.net/podcast09/rss_10175.xml"
	"http://radiofrance-podcast.net/podcast09/rss_15796.xml"
	"http://radiofrance-podcast.net/podcast09/rss_18833.xml"
	"http://radiofrance-podcast.net/podcast09/rss_16609.xml"
	"http://radiofrance-podcast.net/podcast09/rss_18348.xml"
	"http://radiofrance-podcast.net/podcast09/rss_11531.xml"
	"http://radiofrance-podcast.net/podcast09/rss_16392.xml"
	"http://radiofrance-podcast.net/podcast09/rss_12802.xml"
	"http://radiofrance-podcast.net/podcast09/rss_11665.xml"
	"http://radiofrance-podcast.net/podcast09/rss_10059.xml"
	"http://radiofrance-podcast.net/podcast09/rss_10061.xml"
	"http://radiofrance-podcast.net/podcast09/rss_10241.xml"
	"http://radiofrance-podcast.net/podcast09/rss_18918.xml"
	"http://radiofrance-podcast.net/podcast09/rss_14088.xml"
	"http://radiofrance-podcast.net/podcast09/rss_18153.xml"
	"http://feeds.subpop.fm/subpoppodcast"
	"http://radiofrance-podcast.net/podcast09/rss_16559.xml"
	"https://feed.pippa.io/public/shows/un-episode-et-jarrete"))

(setq podcaster-mp3-player-extra-params '("--border=no" "--player-operation-mode=pseudo-gui" "--autofit=10%" "--geometry=100%:100%" "--screen=1"))
