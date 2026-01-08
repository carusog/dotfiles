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

(use-package gcmh
  :ensure t
  :config
  (gcmh-mode 1))

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

(use-package helpful
  :ensure t
  :bind
  ([remap describe-function] . helpful-callable)
  ([remap describe-command] . helpful-command)
  ([remap describe-variable] . helpful-variable)
  ([remap describe-key] . helpful-key))

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

(use-package cape
  :ensure t
  :after corfu
  :init
  ;; Add completion sources to completion-at-point-functions
  ;; Order matters: cape functions complement LSP completion
  (add-to-list 'completion-at-point-functions #'cape-dabbrev)
  (add-to-list 'completion-at-point-functions #'cape-file)
  (add-to-list 'completion-at-point-functions #'cape-keyword))

(use-package tempel
  :ensure t
  :bind (("M-+" . tempel-complete)  ; Complete snippet at point
         ("M-*" . tempel-insert)     ; Insert snippet interactively
         :map tempel-map
         ("TAB" . tempel-next)       ; Navigate to next field
         ("<tab>" . tempel-next)
         ("S-TAB" . tempel-previous) ; Navigate to previous field
         ("<backtab>" . tempel-previous))
  :init
  ;; Set path to snippet templates
  (setq tempel-path (locate-user-emacs-file "templates"))

  ;; Setup completion at point integration
  (defun tempel-setup-capf ()
    (setq-local completion-at-point-functions
                (cons #'tempel-expand
                      completion-at-point-functions)))

  (add-hook 'prog-mode-hook 'tempel-setup-capf)
  (add-hook 'text-mode-hook 'tempel-setup-capf)

  ;; Optionally make tempel-expand a cape capf
  (with-eval-after-load 'cape
    (advice-add 'pcomplete-completions-at-point :around #'cape-wrap-silent)
    (advice-add 'pcomplete-completions-at-point :around #'cape-wrap-purify)))

(use-package consult
  :ensure t
  :bind (("C-s" . consult-line)           ; Better in-buffer search
         ("C-x b" . consult-buffer)       ; Better buffer switching
         ("C-x 4 b" . consult-buffer-other-window)
         ("C-x r b" . consult-bookmark)
         ("M-g g" . consult-goto-line)
         ("M-g M-g" . consult-goto-line)
         ("M-g i" . consult-imenu)        ; Jump to function/class
         ("M-s r" . consult-ripgrep))     ; Project-wide search
  :config
  ;; Enable preview for most commands
  (setq consult-preview-key 'any)
  ;; Add debounce to ripgrep/grep/buffer for better performance
  (consult-customize
   consult-ripgrep consult-grep consult-buffer
   :preview-key '(:debounce 0.4 any)))

(use-package treesit-auto
  :ensure t
  :custom
  (treesit-auto-install 'prompt)  ; Prompt before installing grammars
  :config
  (treesit-auto-add-to-auto-mode-alist 'all)  ; Use tree-sitter modes when available
  (global-treesit-auto-mode))  ; Enable globally

(use-package eglot
  :ensure t
  :defer t
  :hook
  ;; Auto-start eglot in supported language modes
  ((typescript-ts-mode . eglot-ensure)
   (tsx-ts-mode . eglot-ensure)
   (js-ts-mode . eglot-ensure)
   (web-mode . eglot-ensure)
   (css-ts-mode . eglot-ensure)
   (go-ts-mode . eglot-ensure)
   (clojure-mode . eglot-ensure))
  :bind (:map eglot-mode-map
              ("C-c l a" . eglot-code-actions)
              ("C-c l r" . eglot-rename)
              ("C-c l f" . eglot-format-buffer)
              ("C-c l o" . eglot-code-action-organize-imports)
              ("C-c l d" . eldoc-doc-buffer))
  :config
  ;; Performance tuning
  (setq eglot-events-buffer-size 0  ; Disable event logging for performance
        eglot-sync-connect nil        ; Don't block on connection
        eglot-autoshutdown t)         ; Shutdown server when last buffer is killed

  ;; Show more documentation in eldoc
  (setq eldoc-echo-area-use-multiline-p 3)

  ;; Configure server programs for languages
  (add-to-list 'eglot-server-programs
               '((tsx-ts-mode typescript-ts-mode) . ("typescript-language-server" "--stdio")))
  (add-to-list 'eglot-server-programs
               '(web-mode . ("vue-language-server" "--stdio")))

  ;; Add which-key integration for LSP commands
  (with-eval-after-load 'which-key
    (which-key-add-key-based-replacements "C-c l" "LSP"))

  ;; Format buffer on save (Prettier via LSP)
  (defun eglot-format-buffer-on-save ()
    "Format buffer with eglot before saving."
    (add-hook 'before-save-hook #'eglot-format-buffer -10 t))

  ;; Enable format-on-save for web languages
  (add-hook 'typescript-ts-mode-hook #'eglot-format-buffer-on-save)
  (add-hook 'tsx-ts-mode-hook #'eglot-format-buffer-on-save)
  (add-hook 'js-ts-mode-hook #'eglot-format-buffer-on-save)
  (add-hook 'css-ts-mode-hook #'eglot-format-buffer-on-save)
  (add-hook 'web-mode-hook #'eglot-format-buffer-on-save))

(use-package apheleia
  :ensure t
  :config
  (apheleia-global-mode +1))

;; TypeScript/JavaScript with tree-sitter (built-in Emacs 29+)
(use-package typescript-ts-mode
  :ensure nil  ; Built-in
  :config
  (setq typescript-ts-mode-indent-offset 2))

(use-package js-ts-mode
  :ensure nil  ; Built-in
  :config
  (setq js-indent-level 2))

;; CSS with tree-sitter
(use-package css-ts-mode
  :ensure nil  ; Built-in
  :config
  (setq css-indent-offset 2))

;; Go with tree-sitter
(use-package go-ts-mode
  :ensure nil  ; Built-in
  :config
  (setq go-ts-mode-indent-offset 4))

;; Web-mode for JSX, Vue, and Svelte
(use-package web-mode
  :ensure t
  :mode (("\\.jsx\\'" . web-mode)
         ("\\.vue\\'" . web-mode)
         ("\\.svelte\\'" . web-mode))
  :config
  (setq web-mode-markup-indent-offset 2
        web-mode-css-indent-offset 2
        web-mode-code-indent-offset 2
        web-mode-enable-auto-pairing t
        web-mode-enable-css-colorization t))

;; JSON mode
(use-package json-mode
  :ensure t
  :mode "\\.json\\'")

;; YAML mode
(use-package yaml-mode
  :ensure t
  :mode "\\.ya?ml\\'")

;; Markdown mode
(use-package markdown-mode
  :ensure t
  :mode (("\\.md\\'" . markdown-mode)
         ("\\.markdown\\'" . markdown-mode))
  :config
  (setq markdown-command "multimarkdown"))

;; Clojure mode
(use-package clojure-mode
  :ensure t
  :mode (("\\.clj\\'" . clojure-mode)
         ("\\.cljs\\'" . clojure-mode)
         ("\\.cljc\\'" . clojure-mode)))

(use-package emmet-mode
  :ensure t
  :hook ((web-mode . emmet-mode)
         (tsx-ts-mode . emmet-mode)
         (html-mode . emmet-mode)
         (css-mode . emmet-mode)
         (css-ts-mode . emmet-mode))
  :config
  ;; Move cursor between quotes after expansion
  (setq emmet-move-cursor-between-quotes t)
  ;; Bind expansion to C-j (since TAB is used for completion)
  (define-key emmet-mode-keymap (kbd "C-j") 'emmet-expand-line))

(use-package editorconfig
  :ensure t
  :config
  (editorconfig-mode 1))

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

(use-package magit
  :ensure t
  :bind
  (("C-x g" . magit-status)
   ("C-c g s" . magit-status)
   ("C-c g d" . magit-dispatch)
   ("C-c g f" . magit-file-dispatch)
   ("C-c g b" . magit-blame))
  ;; Defer loading until one of these commands is called
  :commands (magit-status magit-get-current-branch)
  :config
  (which-key-add-key-based-replacements "C-c g" "Git")
  :custom
  ;; Open Magit in the current window (like a full screen app) rather than splitting
  (magit-display-buffer-function #'magit-display-buffer-same-window-except-diff-v1))

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

(use-package rainbow-delimiters
  :ensure t
  :hook (prog-mode . rainbow-delimiters-mode))

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
        org-hide-block-startup t
        org-startup-indented t)

  ;; Remove the initial two-spaces indentation inside code block
  (setq org-edit-src-content-indentation 0)
  (setq org-todo-keywords '((sequence "TODO(t)" "WAIT(w)" "SDAY(s)" "PROJ(p)" "|" "DONE(d!)" "CANC(c)")))
  )

;; Set Org-mode default folder
(setq org-directory "~/Documents/org/"
      org-agenda-files '("~/Documents/org/todo.org"))

(use-package org-appear
  :ensure t
  :hook (org-mode . org-appear-mode)
  :config
  (setq org-appear-autoemphasis t
        org-appear-autosubmarkers t
        org-appear-autolinks t))

(use-package org-modern
  :ensure t
  :hook
  (org-mode . org-modern-mode)
  (org-agenda-finalize . org-modern-agenda)
  :config
  (setq ; I am trying to stick with the default fold stars
					; org-modern-star 'replace
					; org-modern-replace-stars "✿❀✺✹✸✷✶✵"
   org-modern-table-vertical 1
   org-modern-table-horizontal 0.2))

(global-set-key (kbd "C-c r") 'remember)
(put 'upcase-region 'disabled nil)
