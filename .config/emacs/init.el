;;; init.el --- My Emacs Configuration

;;; Commentary:
;; This is my personal Emacs configuration file.

;;; Code:
;; Disable Startup Message
(setq inhibit-startup-message t)

;; Configure Backups
(setq backup-directory-alist '(("." . "~/.config/emacs/saves")))
(setq backup-by-copying t) ; Fixes LSP Auto Import Issues

;; Custom File
(setq custom-file "~/.config/emacs/emacs-custom.el")
(load-file custom-file)

;; Scroll Compilation Output
(setq compilation-scroll-output t)

;; UI Tweaks
(tool-bar-mode 0)
(menu-bar-mode 0)
(scroll-bar-mode 0)
(column-number-mode)
(display-time-mode)

;; Editing Preferences
(delete-selection-mode)
(setq-default tab-width 4)
(setq-default indent-tabs-mode nil)
(setq-default c-basic-offset 4)

;; Line Numbers
(global-display-line-numbers-mode)
(setq display-line-numbers-type 'relative)

;; Initialize Packages
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(package-initialize)
(unless package-archive-contents (package-refresh-contents))
(setq use-package-always-ensure t)
(require 'use-package)

;; Font and Appearance
(set-face-attribute 'default nil :font "Space Mono Nerd Font" :height 150)
(use-package catppuccin-theme
  :init (load-theme 'catppuccin :no-confirm))

;; Modeline
(use-package doom-modeline
  :init (doom-modeline-mode))

;; Indent Guides
(use-package highlight-indent-guides
  :hook (prog-mode-hook . highlight-indent-guides-mode)
  :custom ((highlight-indent-guides-method 'bitmap)
	   (highlight-indent-guides-auto-character-face-perc 70)))

;; Multiple Cursors
(use-package multiple-cursors)
(global-set-key (kbd "C-c e") 'mc/edit-lines)
(global-set-key (kbd "C-.") 'mc/mark-next-like-this-word)
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)

;; Swiper
(use-package swiper
  :bind ("C-s" . swiper))

;; Ido & Smex
(ido-mode t)
(use-package smex)
(global-set-key (kbd "M-x") 'smex)

;; Which Key
(use-package which-key
  :init (which-key-mode)
  :config (setq which-key-idle-delay 0.5))

;; Tree Sitter
(use-package tree-sitter
  :hook ((prog-mode . tree-sitter-mode)
         (tree-sitter-after-on . tree-sitter-hl-mode)))
(use-package tree-sitter-langs)

;; Flycheck
(use-package flycheck
  :config (global-flycheck-mode))

;; Rainbow Delimiters
(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

;; Magit
(use-package magit
  :commands magit-status
  :bind ("C-x g" . magit-status))

;; Git Signs
(use-package diff-hl
  :hook ((prog-mode . diff-hl-mode)
	 (prog-mode . diff-hl-flydiff-mode)
	 (magit-post-refresh . diff-hl-magit-post-refresh)))

;; Snippets
(use-package yasnippet
  :config (yas-global-mode))
(use-package yasnippet-snippets)

;; Completion
(use-package company
  :config (global-company-mode)
  :bind ("C-c C-c" . company-complete)
  :custom ((company-tooltip-align-annotations t)
	   (company-format-margin-function 'company-text-icons-margin)
	   (company-text-face-extra-attributes '(:weight bold :slant italic))
	   (company-backends '(company-capf company-yasnippet company-keywords company-files company-elisp company-ispell company-semantic))
	   (company-frontends '(company-preview-frontend company-pseudo-tooltip-frontend))))
;; Update Theme
(custom-set-faces '(company-tooltip ((t (:foreground "#cdd6f4" :background "#181825" :weight bold))))
		  '(company-tooltip-selection ((t (:background "#313244"))))
		  '(company-tooltip-annotation ((t (:foreground "#6c7086" :weight normal :slant italic))))
		  '(company-tooltip-annotation-selection ((t (:weight normal :slant italic))))
		  '(company-preview ((t (:foreground "#6c7086" :background "#1e1e2e"))))
		  '(company-preview-common ((t (:foreground "#6c7086" :background "#1e1e2e"))))
		  '(company-preview-search ((t (:foreground "#6c7086" :background "#1e1e2e"))))
		  '(company-tooltip-search ((t (:foreground "#89b4fa"))))
		  '(company-tooltip-search-selection ((t (:background "#89b4fa")))))

;; Disable DAP UI Controls
(setq dap-auto-configure-features '((sessions locals breakpoints expressions tooltip)))

;; LSP
(use-package lsp-mode
  :commands lsp
  :init (setq lsp-keymap-prefix "C-c l"
	      lsp-headerline-breadcrumb-enable nil)
  :hook (lsp-mode . lsp-enable-which-key-integration))
;; Just Kill the Process
(setq confirm-kill-processes nil)

;; Dart
(use-package dart-mode
  :config (setq lsp-dart-dap-flutter-hot-reload-on-save t)
  :hook (dart-mode . lsp))

;; Rust
(use-package rust-mode)
;; YAML
(use-package yaml-mode
  :config (add-to-list 'auto-mode-alist '("\\.yml\\'" . yaml-mode)))

(provide 'init)
;;; init.el ends here
