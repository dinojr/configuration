;; ~/.emacs.d/JCemms.el -*- mode: lisp-*-
(add-to-list 'load-path "~/git-repositories/emms/lisp/")
(require 'emms-setup)
(require 'emms-browser)

(setq emms-source-file-directory-tree-function 'emms-source-file-directory-tree-find)
(setq emms-source-file-default-directory "/var/lib/mpd/music/NAS/Synology/BEETS/")

(emms-standard)
(emms-default-players)
(emms-cache 1)
(setq emms-cache-file "~/.emacs.d/emms/cache")
(require 'emms-info-libtag)
(setq emms-info-functions '(emms-info-libtag))

(require 'emms-player-mpd)
(setq emms-player-mpd-music-directory "/var/lib/mpd/music/")
(add-to-list 'emms-info-functions 'emms-info-mpd)
(add-to-list 'emms-player-list 'emms-player-mpd)
;; (emms-player-mpd-update-all)
;; (emms-cache-set-from-mpd-all)

;; (emms-player-set emms-player-mpd 'regex
;;                  "\\.ogg\\|\\.mp3\\|\\.wma\\|\\.ogm\\|\\.asf\\|\\.mkv\\|http://\\|mms://\\|\\.rmvb\\|\\.flac\\|\\.vob\\|\\.m4a\\|\\.ape\\|\\.mpc\\|\\.MP3\\|\\.OGG\\|\\.FLAC")

;; (setq emms-player-mpd-supported-regexp
;; 	  (concat "\\`http://\\|"
;; 		  (emms-player-simple-regexp
;; 		   "m3u" "ogg" "flac" "mp3" "wav" "mod" "au" "aiff")))
    
;;     (emms-player-set emms-player-mpd
;; 		     'regex
;; 		     emms-player-mpd-supported-regexp)






;; (emms-player-mpd-update-all-reset-cache)
(setq emms-browser--covers-filename '(("cover_small.jpg" "cover_small.jpeg" "cover_small.png" "cover_small.gif" "cover_small.bmp")
 ("cover_med.jpg" "cover_med.jpeg" "cover_med.png" "cover_med.gif" "cover_med.bmp")
 ("cover_large.jpg" "cover_large.jpeg" "cover_large.png" "cover_large.gif" "cover_large.bmp")))

(setq emms-random-playlist t)

;; (emms-browser)

;; (global-set-key (kbd "<XF86AudioPlay>") 'emms-pause)
;; (global-set-key (kbd "<XF86AudioStop>") 'emms-stop)
;; (global-set-key (kbd "<XF86AudioPrev>") 'emms-previous)
;; (global-set-key (kbd "<XF86AudioNext>") 'emms-next)
