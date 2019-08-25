;; ~/.emacs.d/JCmovie.el -*- mode: emacs-lisp-*-

(add-to-list 'load-path "/home/wilk/git-repositories/movie.el/")
(add-to-list 'load-path "/home/wilk/git-repositories/pvr.el/")
(add-to-list 'load-path "/home/wilk/git-repositories/imdb.el/")
(require 'movie)

(setq movie-player '("mplayer"
    "-vo" "gl"
    ;;"-vc" "ffmpeg12vdpau,ffwmv3vdpau,ffvc1vdpau,ffh264vdpau,ffodivxvdpau,ffhevcvdpau,"
    "-vf" "screenshot"
    "-framedrop" "-hardframedrop" "-nocorrect-pts"
    ;;"-autosync" "30"
    "-volume" "100"
    "-fs"
    "-quiet"
    "-softvol"
    "-ao" "pulse"
    "-heartbeat-cmd" "~/git-repositories/movie.el/xscreensave-off"
    "-delay" "-0.1"
    "-nograbpointer"
    ;;"-ss" "1"
    ;; Pause at the end of files.
    ;;"-loop" "0"
    "-mouse-movements"
    "-cache-min" "99"
    "-cache" "10000"
    "-utf8"
    "-autosub"
    "-subfont-text-scale" "2"
     ))

;; (defun jc-async-movie-find-file (file)
;;   (interactive (list (movie-current-file)))
;;   (async-start
;;    ;; What to do in the child process
;;    (lambda ()
;;      (movie-find-file (file))
;;      )
;; ))
