;; Speed up startup by temporarily increasing garbage collector threshold
(setq gc-cons-threshold most-positive-fixnum)

;; Lower it back to a reasonable level after startup
(add-hook 'emacs-startup-hook
          (lambda ()
            (setq gc-cons-threshold (* 2 1024 1024))))

;; proportionately-spaced-font "Noto Sans Display"
(let ((mono-spaced-font "JetBrainsMono Nerd Font Mono")
        (proportionately-spaced-font "ETBembo"))

    (set-face-attribute 'default nil :family mono-spaced-font :height 160)
    ;; Ensure fixed-pitch inherits the correct family and height from default
    (set-face-attribute 'fixed-pitch nil :family mono-spaced-font :height 1.0)
    (set-face-attribute 'variable-pitch nil :family proportionately-spaced-font :height 1.0))

  ;; How to "properly" set line height in Emacs
  ;; Source: https://github.com/syl20bnr/spacemacs/issues/10502#issuecomment-404453194
  (defun set-bigger-spacing ()
    (setq-local default-text-properties '(line-spacing 0.25 line-height 1.25)))

  (add-hook 'text-mode-hook 'set-bigger-spacing)
  (add-hook 'prog-mode-hook 'set-bigger-spacing)

;; Load the theme immediately so the frame is colored correctly on startup
;; Modus-themes are built-in, so we don't need use-package here.
(setq modus-themes-disabled-other-themes t)
(load-theme 'modus-operandi-tinted :no-confirm-loading)

;; Prevent the flashy menu-bar and tool-bar from even loading
(push '(menu-bar-lines . 0) default-frame-alist)
(push '(tool-bar-lines . 0) default-frame-alist)
(push '(vertical-scroll-bars) default-frame-alist)
