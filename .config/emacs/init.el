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
(global-display-line-numbers-mode)
(setq display-line-numbers-type 'relative)

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
  :custom (which-key-idle-delay 0.5)
  :config (which-key-mode))

;; Tree Sitter
(use-package treesit-auto
  :custom ((treesit-auto-install t)
           (treesit-auto-add-to-auto-mode-alist 'all))
  :config (global-treesit-auto-mode))

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
  :bind ("C-c C-SPC" . company-other-backend)
  :custom ((company-tooltip-align-annotations t)
           (company-format-margin-function 'company-text-icons-margin)
           (company-backends '(company-files company-capf company-yasnippet company-dabbrev-code company-dabbrev))
           (company-frontends '(company-preview-frontend company-pseudo-tooltip-frontend company-echo-metadata-frontend))))

;; Flycheck
(use-package flycheck
  :config (global-flycheck-mode))

;; LSP
(use-package lsp-mode
  :commands (lsp lsp-deferred)
  :custom ((lsp-keymap-prefix "C-c l")
           (lsp-headerline-breadcrumb-enable nil)
           (confirm-kill-processes nil))
  :hook (lsp-mode . lsp-enable-which-key-integration))
(use-package lsp-ui
  :custom ((lsp-ui-sideline-show-hover t)
           (lsp-ui-sideline-show-code-actions t)
           (lsp-ui-doc-position 'at-point))
  :config
  (define-key lsp-ui-mode-map [remap xref-find-definitions] #'lsp-ui-peek-find-definitions)
  (define-key lsp-ui-mode-map [remap xref-find-references] #'lsp-ui-peek-find-references)
  (keymap-set lsp-ui-mode-map "C-c k" #'lsp-ui-doc-glance)
  (keymap-set lsp-ui-mode-map "C-c K" #'lsp-ui-doc-focus-frame))

;; Dart
(use-package dart-mode
  :hook (dart-mode . lsp-deferred))
(use-package lsp-dart
  :config (setq lsp-dart-dap-flutter-hot-reload-on-save t
                dap-auto-configure-features '((sessions locals breakpoints expressions tooltip))))

;; Rust
(add-to-list 'auto-mode-alist '("\\.rs\\'" . rust-ts-mode))
(add-hook 'rust-ts-mode-hook #'lsp-deferred)
(use-package flycheck-rust
  :hook (flycheck-mode . flycheck-rust-setup))

;; YAML
(use-package yaml-mode
  :config (add-to-list 'auto-mode-alist '("\\.yml\\'" . yaml-mode)))

;; Typst
(unless (package-installed-p 'typst-ts-mode)
  (package-vc-install "https://codeberg.org/meow_king/typst-ts-mode.git"))
(use-package typst-ts-mode
  :custom ((typst-ts-mode-enable-raw-blocks-highlight t)
           (typst-ts-mode-grammar-location (expand-file-name "tree-sitter/libtree-sitter-typst.so" user-emacs-directory)))
  :config (keymap-set typst-ts-mode-map "C-c C-c" #'typst-ts-tmenu))

(provide 'init)

;; Local Variables:
;; byte-compile-warnings: (not unresolved free-vars)
;; End:

;;; init.el ends here
