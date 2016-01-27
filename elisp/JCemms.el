;; ~/.emacs.d/JCemms.el -*- mode: lisp-*-

(require 'emms-setup)
(emms-standard)
(emms-default-players)
;; (setq emms-source-file-directory-tree-function 'emms-source-file-directory-tree-find)

(require 'emms-player-mpd)
(add-to-list 'emms-info-functions 'emms-info-mpd)
(add-to-list 'emms-player-list 'emms-player-mpd)
(emms-player-set emms-player-mpd 'regex
                 "\\.ogg\\|\\.mp3\\|\\.wma\\|\\.ogm\\|\\.asf\\|\\.mkv\\|http://\\|mms://\\|\\.rmvb\\|\\.flac\\|\\.vob\\|\\.m4a\\|\\.ape\\|\\.mpc\\|\\.MP3\\|\\.OGG\\|\\.FLAC")
(setq emms-player-mpd-music-directory "/var/lib/mpd/music/")
(emms-cache 1)
(setq emms-cache-file "~/.emacs.d/emms/cache")
;; (setq emms-source-file-default-directory "/srv/multimedia/musique/")

(emms-cache-set-from-mpd-all)

(setq emms-browser--covers-filename '(("cover_small.jpg" "cover_small.jpeg" "cover_small.png" "cover_small.gif" "cover_small.bmp")
 ("cover_med.jpg" "cover_med.jpeg" "cover_med.png" "cover_med.gif" "cover_med.bmp")
 ("cover_large.jpg" "cover_large.jpeg" "cover_large.png" "cover_large.gif" "cover_large.bmp")))
(require 'emms-browser)
;; (emms-browser)

