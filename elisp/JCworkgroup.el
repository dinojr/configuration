;; ~/.emacs.d/JCworkgroup.el

(require 'workgroups)
(setq wg-morph-on nil)

;; (setq wg-morph-vsteps 3)
;; (setq wg-morph-hsteps 3)

;; C-c w est le standard, mais déjà utilisé pour browse-url
(setq wg-prefix-key [f1])

(workgroups-mode 1)
(if (not server-mode)
    (wg-load "/home/wilk/.emacs.d/workgroups.el")
  )


(defun jc-switch-to-workgroup (workgroup)
  (if (not (string= (wg-name (wg-current-workgroup 1))  workgroup)) 
      (wg-switch-to-workgroup (wg-get-workgroup 'name workgroup)))
)

(defun jc-jump-to-org-agenda ()
  (interactive)
  ;; (if (not (string= (wg-name (wg-current-workgroup 1)) "org")) 
  ;;   (wg-switch-to-workgroup (wg-get-workgroup 'name "org")))
  (jc-switch-to-workgroup "org")
  (let ((buf (get-buffer "*Org Agenda*"))
        wind)
    (if buf
        (if (setq wind (get-buffer-window buf))
            (when (called-interactively-p 'any)
              (select-window wind)
              (org-fit-window-to-buffer))
          (if (called-interactively-p 'any)
              (progn
                (select-window (display-buffer buf t t))
                (org-fit-window-to-buffer))
            (with-selected-window (display-buffer buf)
              (org-fit-window-to-buffer))))
      (call-interactively 'org-agenda-list)
      ;; (org-agenda-redo)
      )))

(global-set-key [f5] (lambda () (interactive) (jc-switch-to-workgroup "org")))
(global-set-key [f6] (lambda () (interactive) (jc-switch-to-workgroup "gnus")))
(global-set-key [f7] (lambda () (interactive) (jc-switch-to-workgroup "latex")))
(global-set-key [f8] (lambda () (interactive) (jc-switch-to-workgroup "bitlbee")))

(global-set-key [f9] 'jc-jump-to-org-agenda)
(global-set-key [f10] 'jc-jump-to-gnus)
(global-set-key [f11] 'jc-jump-to-mingus)
(global-set-key [f12] 'jc-jump-to-bitlbee)



(defun jc-dired-find-file-latex ()
  "In Dired, visit this file or directory and switch to workgroup latex"
  (interactive)
  (let 
      ((file (dired-get-file-for-visit)))
    (jc-switch-to-workgroup "latex")
    (find-file file)
    )
  )
(eval-after-load "dired"
  '(define-key dired-mode-map (kbd "<f1> o") 'jc-dired-find-file-latex))


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
