;; ~/.emacs.d/JCgnus.el -*- mode: lisp-*-

(setq load-path (cons (expand-file-name "/home/wilk/info/emacs/gnus/lisp") load-path))
;; (add-to-list 'load-path "~/info/emacs/gnus/lisp")
(add-to-list 'load-path "~/.emacs.d/gnus-bogofilter")

(require 'gnus-load)
(setq user-full-name "Julien Cubizolles")
(setq user-mail-address "j.cubizolles@free.fr")

(add-hook 'gnus-message-setup-hook 'turn-on-auto-fill)

(eval-after-load 'gnus 
  (lambda ()
    (add-hook 'gnus-agent-plugged-hook 'jc-gnus-open-agentized-servers)
    ;; (add-hook 'gnus-agent-plugged-hook 'jc-nuke-newsletter-group)
    )
  )

(defun jc-jump-to-gnus ()
  (interactive)
  ;; (if (not (string= (wg-name (wg-current-workgroup 1)) "gnus")) 
  ;;   (wg-switch-to-workgroup (wg-get-workgroup 'name "gnus")))
  (jc-switch-to-workgroup "gnus")
  (let ((alist
         '(("\\`\\*unsent")
           ("\\`\\*Article")
           ("\\`\\*Summary")
           ("\\`\\*Group"
            (lambda (buf)
              (with-current-buffer buf
                (gnus-group-get-new-news))))))
        candidate)
    (catch 'found
      (dolist (item alist)
        (let ((regexp (nth 0 item))
              (test (nth 1 item))
              last)
          (dolist (buf (buffer-list))
            (if (string-match regexp (buffer-name buf))
                (setq last buf)))
          (if (and last (or (null test)
                            (funcall test last)))
              (throw 'found (setq candidate last))))))
    (if candidate
        (ido-visit-buffer candidate ido-default-buffer-method)
      (gnus-unplugged)
      ;; (gnus)
      )))

(defun jc-gnus-summary-copy-and-expire-article (&optional n to-newsgroup select-method)
  "Copy the current article to some other group and mark it as expirable.
If TO-NEWSGROUP is string, do not prompt for a newsgroup to copy to.
When called interactively, if TO-NEWSGROUP is nil, use the value of
the variable `gnus-move-split-methods' for finding a default target."
  (interactive "P")
  (let ((articles (gnus-summary-work-articles n))
	article)
    (gnus-summary-move-article n to-newsgroup select-method 'copy)
    (save-excursion
      (while articles
    	(gnus-summary-goto-subject (setq article (pop articles)))
    	(let (gnus-newsgroup-processable)
    	  (command-execute 'gnus-summary-mark-as-expirable))
    	(gnus-summary-remove-process-mark article)))
    )
  )

(defun jc-gnus-summary-move-and-mark-read-article (&optional n to-newsgroup select-method)
  "Move the current article to some other group and mark it as read.
If TO-NEWSGROUP is string, do not prompt for a newsgroup to copy to.
When called interactively, if TO-NEWSGROUP is nil, use the value of
the variable `gnus-move-split-methods' for finding a default target."
  (interactive "P")
  (let ((articles (gnus-summary-work-articles n))
	  article)
    (save-excursion
      (while articles
    	(gnus-summary-goto-subject (setq article (pop articles)))
	(let (gnus-newsgroup-processable)
	  (command-execute 'gnus-summary-mark-as-read-forward article))
    	)
      )
    (gnus-summary-move-article n to-newsgroup select-method)
    (gnus-summary-remove-process-mark article)
    )
  )

(defun message-goto-gcc ()
  "Move point to the Gcc header."
  (interactive)
  (push-mark)
  (message-position-on-field "Gcc" "Bcc" "Cc" "To"))

;; Cleanup all Gnus buffers on exit

(defun exit-gnus-on-exit ()
  (if (and (fboundp 'gnus-group-exit)
	   (gnus-alive-p))
      (with-current-buffer (get-buffer "*Group*")
	(let (gnus-interactive-exit)
	  (gnus-group-exit)))))

(add-hook 'kill-emacs-hook 'exit-gnus-on-exit)

;; Raccourcis
(global-set-key "\C-cm" 'gnus-group-mail)

(eval-after-load 'gnus-load
  (lambda ()
    (define-key gnus-summary-mode-map (kbd "B a") 'jc-gnus-summary-copy-and-expire-article)
    (define-key gnus-summary-mode-map (kbd "B M") 'jc-gnus-summary-move-and-mark-read-article)
    )
  )

(add-hook 'message-mode-hook
	  (lambda ()
	    (define-key message-mode-map [C-tab] 'bbdb-complete-mail)
	    (define-key message-mode-map "\C-c\C-f\C-g" 'message-goto-gcc)
	    )
	  )
