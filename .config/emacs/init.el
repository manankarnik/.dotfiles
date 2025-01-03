;;; init.el --- My Emacs Configuration

;;; Commentary:
;; This is my personal Emacs configuration file.

;;; Code:
;; General Settings
(setq inhibit-startup-message t)
(setq compilation-scroll-output t)
(setq shell-file-name "/bin/bash")
(setq backup-by-copying t)
(setq backup-directory-alist '(("." . "~/.config/emacs/saves")))
(setq custom-file "~/.config/emacs/emacs-custom.el")
(load-file custom-file)

;; User Interface
(tool-bar-mode 0)
(menu-bar-mode 0)
(scroll-bar-mode 0)
(column-number-mode)
(display-time-mode)
(setq display-line-numbers-type 'relative)
(global-display-line-numbers-mode)

;; Editing Preferences
(delete-selection-mode)
(setq-default tab-width 4)
(setq-default indent-tabs-mode nil)
(setq-default c-basic-offset 4)

;; Initialize Packages
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(package-initialize)
(unless package-archive-contents (package-refresh-contents))
(setq use-package-always-ensure t)
(require 'use-package)

;; Font and Appearance
(set-face-attribute 'default nil :font "CodeNewRoman Nerd Font Mono" :height 150)
(use-package catppuccin-theme
  :config (load-theme 'catppuccin :no-confirm))

;; Modeline
(use-package doom-modeline
  :config (doom-modeline-mode))

;; Multiple Cursors
(use-package multiple-cursors)
(global-set-key (kbd "C-c e")   'mc/edit-lines)
(global-set-key (kbd "C-.")     'mc/mark-next-like-this-word)
(global-set-key (kbd "C->")     'mc/mark-next-like-this)
(global-set-key (kbd "C-<")     'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)

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

;; Magit
(use-package magit
  :commands magit-status
  :bind ("C-x g" . magit-status))

;; Snippets
(use-package yasnippet
  :config (yas-global-mode))
(use-package yasnippet-snippets)

;; Completion
(use-package company
  :config (global-company-mode)
  :bind ("C-c c" . company-complete)
  :custom ((company-tooltip-align-annotations t)
	       (company-format-margin-function 'company-text-icons-margin)
           (company-backends '(company-files company-yasnippet company-capf company-dabbrev))
           (company-frontends '(company-preview-frontend company-pseudo-tooltip-frontend company-echo-metadata-frontend))))

;; Disable DAP UI Controls
(setq dap-auto-configure-features '((sessions locals breakpoints expressions tooltip)))

;; LSP
(use-package lsp-mode
  :commands lsp
  :config (setq lsp-keymap-prefix "C-c l"
                lsp-headerline-breadcrumb-enable nil
                confirm-kill-processes nil)
  :hook (lsp-mode . lsp-enable-which-key-integration))

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
