;; ~/.emacs.d/JCcompany.el -*- mode: emacs-lisp-*-

(add-hook 'after-init-hook 'global-company-mode)
(company-auctex-init)

;; local configuration for TeX modes
(defun jc-company-latex-mode-setup ()
  (setq-local company-backends
              (append '(company-math-symbols-latex company-latex-commands company-math-symbols-unicode)
                      company-backends)))

(add-hook 'LaTeX-mode-hook 'jc-company-latex-mode-setup)
(add-hook 'ConTeXt-mode-hook 'jc-company-latex-mode-setup)
(add-hook 'org-mode-hook 'jc-company-latex-mode-setup)
