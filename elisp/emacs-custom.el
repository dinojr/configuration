(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(LaTeX-math-abbrev-prefix [249])
 '(TeX-engine 'luatex)
 '(ace-isearch-function 'avy-goto-word-1)
 '(ace-isearch-input-length 5)
 '(ace-isearch-jump-delay 0.25)
 '(ace-isearch-use-jump 'printing-char)
 '(beacon-color "#ff79c6")
 '(canlock-password "5052bb55e61c64dae5204c0ccac4d417b05d8cf8")
 '(custom-file "~/.emacs.d/emacs-custom.el")
 '(custom-safe-themes
   '("f866a897c7109728ee82111b253bf0531eb44d8379b6bfa9a3aba4568e1ee338" "ed8e6f452855fc7338c8be77803666b34745c19c6667197db48952107fa6d983" "a0be7a38e2de974d1598cf247f607d5c1841dbcef1ccd97cded8bea95a7c7639" "4f1d2476c290eaa5d9ab9d13b60f2c0f1c8fa7703596fa91b235db7f99a9441b" "96871555d64815a906796e1e594a91245c2327c2bf57ec87ddf9c1668ef6069c" "e6ff132edb1bfa0645e2ba032c44ce94a3bd3c15e3929cdf6c049802cf059a2a" "b0fd04a1b4b614840073a82a53e88fe2abc3d731462d6fde4e541807825af342" "43c808b039893c885bdeec885b4f7572141bd9392da7f0bd8d8346e02b2ec8da" "c0dc50b8b69b5fa91e65f5370b9605ced947db9d05e84552b4d31586e3874be8" "e23658d315acf2744418f199019b09d0522285c100f1772bdd948f3e5a287e61" "506a18c9dcffa6a7e70635a99e3b55c40595dc2561bced63a9023b2c148cc813" "218bc69ef19fd1f681cdded7b85924e41242fe87a6033df823499822f1397f1a" "3c83b3676d796422704082049fc38b6966bcad960f896669dfc21a7a37a748fa" default))
 '(font-latex-fontify-sectioning 'color)
 '(font-latex-quotes 'french)
 '(helm-completion-style 'emacs)
 '(helm-external-programs-associations
   '(("docx" . "libreoffice")
     ("pdf" . "xournalpp")
     ("sciprj" . "scidavis")
     ("odt" . "libreoffice")
     ("ods" . "libreoffice")
     ("doc" . "libreoffice")
     ("gcrystal" . "gcrystal")
     ("qti" . "scidavis")
     ("xopp" . "xournalpp")
     ("agr" . "xmgrace")
     ("7z" . "file-roller")
     ("avi" . "mpv")
     ("jpg" . "eog")
     ("m4v" . "mpv")
     ("mkv" . "mpv")
     ("mp4" . "mpv")
     ("xls" . "libreoffice")
     ("xlsx" . "libreoffice")
     ("zip" . "file-roller")))
 '(helm-source-names-using-follow '("Global Bindings Starting With C-c h C-c:" "RG" "Occur"))
 '(ignored-local-variable-values '((make-backup-files)))
 '(notmuch-saved-searches
   '((:name "inbox" :query "tag:inbox" :key "i")
     (:name "unread" :query "tag:unread" :key "u")
     (:name "flagged" :query "tag:flagged" :key "f")
     (:name "sent" :query "tag:sent" :key "t")
     (:name "drafts" :query "tag:draft" :key "d")
     (:name "all mail" :query "*" :key "a")
     (:name "pending-tagging" :query "(not path:News/agent/nntp/**) and (not folder:Maildir/Free/Commercial) and (not folder:\"Mail/Free/Réseaux Sociaux\") and not folder:Local/junk and (not path:Maildir/Gmail/Categories/**) and date:30days.. and (not from:ebay) and (not from:Facebook) and tag:new" :key "g" :search-type tree)))
 '(org-archive-save-context-info '(itags ltags))
 '(org-format-latex-options
   '(:foreground default :background default :scale 2.0 :html-foreground "Black" :html-background "Transparent" :html-scale 1.0 :matchers
		 ("begin" "$1" "$" "$$" "\\(" "\\[")))
 '(org-list-allow-alphabetical t)
 '(org-safe-remote-resources
   '("\\`https://fniessen\\.github\\.io/org-html-themes/org/theme-readtheorg\\.setup\\'"))
 '(package-selected-packages
   '(consult-notmuch corfu popper consult-dir wgrep vertico dashboard mpdmacs python-mode jupyter zmq org-drill org-mru-clock 0blayout annotate catppuccin-theme osm display-wttr transpose-frame nov helm-system-packages helm-systemd eshell-syntax-highlighting pocket-reader helm-lsp lsp-jedi lsp-latex lsp-mode lsp-pyright lsp-treemacs lsp-ui khardel vdirel avy-embark-collect consult consult-flycheck embark embark-consult marginalia orderless prescient selectrum selectrum-prescient burly key-assist eri dumb-jump org-mind-map graphviz-dot-mode org-brain org-superstar company-emoji company-reftex emojify helm-org perspective doom-modeline helm-dash helm-flymake helm-flyspell helm-org-rifle helm-xref doom-themes ztree orgit bug-hunter podcaster highlight-indent-guides eyebrowse yasnippet-snippets yaml-mode xpm wttrin worf w3m use-package unison-mode unison twittering-mode tabbar sx swiper-helm spaceline smartparens smart-mode-line rainbow-mode rainbow-delimiters pyvenv pinentry paredit paradox org-review org-ref org-pdfview org-easy-img-insert org-download org-caldav offlineimap oauth2 notify moody minions mingus memory-usage major-mode-icons magithub magit-filenotify lispy linum-relative latex-extra keychain-environment ivy-todo ivy-rich ivy-mpdel ivy-dired-history ivy-bibtex helm-notmuch helm-flycheck helm-flx helm-ext helm-emms helm-describe-modes helm-descbinds helm-company helm-bind-key helm-bbdb helm-ag google-maps gnuplot-mode gnuplot gh free-keys font-lock+ flyspell-lazy flyspell-correct-ivy flyspell-correct-helm flymake-yaml expand-region exec-path-from-shell eww-lnum emms-mode-line-cycle emms-info-mediainfo easy-kill dired-toggle-sudo counsel-tramp counsel-notmuch counsel-gtags counsel-etags counsel-bbdb company-math company-auctex calfw-gcal calfw boxquote bitlbee beacon bbdb2erc bbdb-vcard bbdb-ext bbdb- autopair auto-dictionary auctex-latexmk anzu all-the-icons-ivy all-the-icons-gnus all-the-icons-dired ace-jump-mode ace-jump-helm-line ace-flyspell multi-line zenburn-theme wajig use-package-chords org-notebook md4rd helm-eww guru-mode google-this gnus-alias emacs-xkcd diminish csv-mode counsel-ebdb company-php cdlatex calfw-org calfw-ical calfw-cal auto-yasnippet auto-overlays anaphora ace-link ace-isearch))
 '(paradox-automatically-star nil)
 '(paradox-github-token t)
 '(reftex-toc-include-labels t)
 '(reftex-toc-split-windows-horizontally t)
 '(safe-local-variable-values
   '((eval org-sbe "initialisation")
     (org-confirm-babel-evaluate)
     (TeX-PDF-from-DVI . Dvips)
     (org-download-image-dir . "./Resources/")))
 '(warning-suppress-types '(((undo discard-info)) ((undo discard-info)))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
