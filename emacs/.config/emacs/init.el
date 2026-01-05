(setq user-full-name "Giuseppe Caruso"
      user-mail-address "peppecaruso@gmail.com")

(setq custom-file (locate-user-emacs-file "custom.el"))
(load custom-file :no-error-if-file-is-missing)

(require 'package)

;; In Emacs 27+, this is called automatically after early-init.el but before init.el.
;; Commented this line to save a few milliseconds.
;; (package-initialize)

(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))

(when (< emacs-major-version 29)
  (unless (package-installed-p 'use-package)
    (unless package-archive-contents
      (package-refresh-contents))
    (package-install 'use-package)))
(require 'use-package)

(add-to-list 'display-buffer-alist
             '("\\`\\*\\(Warnings\\|Compile-Log\\)\\*\\'"
               (display-buffer-no-window)
               (allow-no-window . t)))

(use-package doom-modeline
  :ensure t
  :init (doom-modeline-mode 1))

(line-number-mode t)
(column-number-mode t)
(size-indication-mode t)

;; (use-package modus-themes
;;   :ensure t)

(use-package spacious-padding
  :ensure t
  :init (spacious-padding-mode 1))

;; Highlight current line
;; (global-hl-line-mode +1)

(use-package delsel
  :ensure nil
  :hook (after-init . delete-selection-mode))

(defun prot/keyboard-quit-dwim ()
  "Do-What-I-Mean behavior for `keyboard-quit`."
  (interactive)
  (cond
   ((region-active-p)
    (keyboard-quit))
   ((derived-mode-p 'completion-list-mode)
    (delete-completion-window))
   ((> (minibuffer-depth) 0)
    (abort-recursive-edit))
   (t
    (keyboard-quit))))

(define-key global-map (kbd "C-g") #'prot/keyboard-quit-dwim)

;; Disable the splash screen (to enable it agin, replace the t with 0)
(setq inhibit-splash-screen t)

(use-package which-key
  :ensure t
  :init
  (which-key-mode)
  :config
  ;; idle-delay: How long to wait before showing the popup (default is 1.0)
  (setq which-key-idle-delay 0.5)

  (setq which-key-popup-type 'side-window
        which-key-side-window-max-height 0.333))

(use-package nerd-icons
  :ensure t)

(use-package nerd-icons-completion
  :ensure t
  :after marginalia
  :config
  (add-hook 'marginalia-mode-hook #'nerd-icons-completion-marginalia-setup))

(use-package nerd-icons-corfu
  :ensure t
  :after corfu
  :config
  (add-to-list 'corfu-margin-formatters #'nerd-icons-corfu-formatter))

(use-package nerd-icons-dired
  :ensure t
  :hook (dired-mode . nerd-icons-dired-mode))

(use-package vertico
  :ensure t
  :hook (after-init . vertico-mode))

(use-package marginalia
  :ensure t
  :hook (after-init . marginalia-mode))

(use-package orderless
  :ensure t
  :config
  (setq completion-styles '(orderless basic))
  (setq completion-category-defaults nil)
  (setq completion-category-overrides nil))

(use-package savehist
  :ensure nil
  :hook (after-init . savehist-mode))

(use-package corfu
  :ensure t
  :hook (after-init . global-corfu-mode)
  :bind (:map corfu-map ("<tab>" . corfu-complete))
  :config
  (setq tab-always-indent 'complete
        corfu-preview-current nil
        corfu-min-width 20
        corfu-popupinfo-delay '(1.25 . 0.5))
  (corfu-popupinfo-mode 1)
  (with-eval-after-load 'savehist
    (corfu-history-mode 1)
    (add-to-list 'savehist-additional-variables 'corfu-history)))

(use-package dired
  :ensure nil
  :hook
  ((dired-mode . dired-hide-details-mode)
   (dired-mode . hl-line-mode))
  :config
  (setq dired-recursive-copies 'always
        dired-recursive-deletes 'always
        delete-by-moving-to-trash t
        dired-dwim-target t))

(use-package dired-subtree
  :ensure t
  :after dired
  :bind (:map dired-mode-map
              ("<tab>" . dired-subtree-toggle)
              ("TAB" . dired-subtree-toggle)
              ("<backtab>" . dired-subtree-remove)
              ("S-TAB" . dired-subtree-remove))
  :config
  (setq dired-subtree-use-backgrounds nil))

(use-package trashed
  :ensure t
  :commands (trashed)
  :config
  (setq trashed-action-confirmer 'y-or-n-p
        trashed-use-header-line t
        trashed-sort-key '("Date deleted" . t)
        trashed-date-format "%Y-%m-%d %H:%M:%S"))

(use-package smartparens
  :ensure t
  :diminish smartparens-mode
  :config
  (require 'smartparens-config)
  (smartparens-global-mode 1)
  (show-paren-mode t))

(use-package expand-region
  :ensure t
  ;; expand "meta + m", contract "meta + shift + m"
  :bind (("M-m" . er/expand-region) ("M-M" . er/contract-region)))

(transient-mark-mode 1)

(use-package org
  ;; :hook
  ;; ((org-mode . variable-pitch-mode))

  :bind
  ("C-c a" . org-agenda)
  ("C-c c" . org-capture)
  ("C-c l" . org-store-link)

  :config
  ;; Basic Org settings
  (setq org-hide-leading-stars t
	org-hide-emphasis-markers t
	org-ellipsis " ⇥ "
        org-hide-block-startup t)

  ;; Remove the initial two-spaces indentation inside code block
  (setq org-edit-src-content-indentation 0)
  (setq org-todo-keywords '((sequence "TODO(t)" "WAIT(w)" "SDAY(s)" "PROJ(p)" "|" "DONE(d!)" "CANC(c)")))
)

;; Set Org-mode default folder
(setq org-directory "~/Documents/org/"
      org-agenda-file "~/Documents/org/")

;; (use-package org-superstar
;;   :ensure t
;;   :hook (org-mode . org-superstar-mode)
;;   :config
;;   (setq org-superstar-special-todo-items t)
;;   (setq org-superstar-headline-bullets-list
;;         '("✿" "❀" "✺ " "✹ " "✸ " "✷ " "✶ " "✵")))

(global-set-key (kbd "C-c r") 'remember)
