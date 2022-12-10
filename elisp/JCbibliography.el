;;~/.emacs.d/JCbibliography.el -*- mode: emacs-lisp-*-

(setq reftex-default-bibliography '("~/enseignement/papiers/bibliography.bib"))

;; see org-ref for use of these variables
(setq org-ref-bibliography-notes "~/enseignement/papiers/notes.org"
      org-ref-default-bibliography '("~/enseignement/papiers/bibliography.bib")
      org-ref-pdf-directory "~/enseignement/papiers/")


(setq bibtex-completion-bibliography '("~/enseignement/papiers/bibliography.bib" "~/enseignement/doc_cours/attributions.bib"))
(setq bibtex-completion-library-path "~/enseignement/papiers/")

;; Sci-hub
(defun sci-hub-pdf-url (doi)
  "Get url to the pdf from SCI-HUB"
  (setq *doi-utils-pdf-url* (concat "https://sci-hub.se/" doi) ;captcha
        *doi-utils-waiting* t
        )
  ;; try to find PDF url (if it exists)
  (url-retrieve (concat "https://sci-hub.se/" doi)
            (lambda (status)
              (goto-char (point-min))
              (while (search-forward-regexp "\\(https://\\|//sci-hub.se/downloads\\).+download=true'" nil t)
                (let ((foundurl (match-string 0)))
                  (message foundurl)
                  (if (string-match "https:" foundurl)
                  (setq *doi-utils-pdf-url* foundurl)
                (setq *doi-utils-pdf-url* (concat "https:" foundurl))))
                (setq *doi-utils-waiting* nil))))
  (while *doi-utils-waiting* (sleep-for 0.1))
  *doi-utils-pdf-url*)


;; https://emacs.stackexchange.com/questions/58861/using-org-ref-to-download-pdfs-using-sci-hub-as-a-fallback adapter le lien sci-hub.se si nécessaire

(defun doi-utils-get-bibtex-entry-pdf (&optional arg)
  "Download pdf for entry at point if the pdf does not already exist locally.
The entry must have a doi. The pdf will be saved to
`org-ref-pdf-directory', by the name %s.pdf where %s is the
bibtex label.  Files will not be overwritten.  The pdf will be
checked to make sure it is a pdf, and not some html failure
page. You must have permission to access the pdf. We open the pdf
at the end if `doi-utils-open-pdf-after-download' is non-nil.

With one prefix ARG, directly get the pdf from a file (through
`read-file-name') instead of looking up a DOI. With a double
prefix ARG, directly get the pdf from an open buffer (through
`read-buffer-to-switch') instead. These two alternative methods
work even if the entry has no DOI, and the pdf file is not
checked."
  (interactive "P")
  (save-excursion
    (bibtex-beginning-of-entry)
    (let (;; get doi, removing http://dx.doi.org/ if it is there.
          (doi (replace-regexp-in-string
		"https?://\\(dx.\\)?.doi.org/" ""
		(bibtex-autokey-get-field "doi")))
          (key (cdr (assoc "=key=" (bibtex-parse-entry))))
          (pdf-url)
          (pdf-file))
      (setq pdf-file (concat
		      (if org-ref-pdf-directory
			  (file-name-as-directory org-ref-pdf-directory)
			(read-directory-name "PDF directory: " "."))
		      key ".pdf"))
      ;; now get file if needed.
      (unless (file-exists-p pdf-file)
	(cond
	 ((and (not arg)
               doi
               (if (doi-utils-get-pdf-url doi)
		   (setq pdf-url (doi-utils-get-pdf-url doi))
		 (setq pdf-url "https://www.sciencedirect.com/science/article/")))
          (url-copy-file pdf-url pdf-file)        
          ;; now check if we got a pdf
          (if (org-ref-pdf-p pdf-file)
              (message "%s saved" pdf-file)
            (delete-file pdf-file)
            ;; sci-hub fallback option
            (setq pdf-url (sci-hub-pdf-url doi))
            (url-copy-file pdf-url pdf-file)
            ;; now check if we got a pdf
            (if (org-ref-pdf-p pdf-file)
		(message "%s saved" pdf-file)
              (delete-file pdf-file)
              (message "No pdf was downloaded.") ; SH captcha
              (browse-url pdf-url))))
	 ;; End of sci-hub fallback option
	 ((equal arg '(4))
          (copy-file (expand-file-name (read-file-name "Pdf file: " nil nil t))
		     pdf-file))
	 ((equal arg '(16))
          (with-current-buffer (read-buffer-to-switch "Pdf buffer: ")
            (write-file pdf-file)))
	 (t
          (message "We don't have a recipe for this journal.")))
	(when (and doi-utils-open-pdf-after-download (file-exists-p pdf-file))
          (org-open-file pdf-file))))))
