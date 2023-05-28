;;; .emacs --- Settings for Emacs
;;; Commentary:
;;; Build for Python

;;; Code:
(setq gnutls-algorithm-priority "NORMAL:-VERS-TLS1.3")
;; Disable welcome buffer *GNU Emacs*
(setq inhibit-startup-screen t)
;; Python interpreter
(setq python-shell-interpreter "python3.11")
;; Save session
(desktop-save-mode 1)

;; (setq vc-handled-backends nil) ;; Disable vc-git

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(setq package-selected-packages
      `(
	lsp-ui
	company
	lsp-pyright
	flycheck
	lsp-mode
	exec-path-from-shell
	magit
	markdown-mode))

(require 'package)
(add-to-list 'package-archives
             '("melpa-stable" . "http://stable.melpa.org/packages/"))

;; Initilize packages
(package-initialize)

;;; Bootstrapping use-package
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(eval-when-compile (require 'use-package))

(use-package use-package
  :config
  (setq use-package-always-ensure t))

;; Added support gnome-keyring
(exec-path-from-shell-copy-env "SSH_AUTH_SOCK")
(when (memq window-system '(mac ns x))
  (exec-path-from-shell-initialize))

;; Init Flycheck
(global-flycheck-mode)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(column-number-mode t)
 '(custom-enabled-themes '(deeper-blue))
 '(display-battery-mode t)
 '(display-line-numbers-type 'relative)
 '(global-display-line-numbers-mode t)
 '(markdown-command "/usr/bin/pandoc")
 '(warning-suppress-types '((comp))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Noto Sans" :foundry "GOOG" :slant normal :weight normal :height 98 :width normal)))))

;; Setting LSP
(use-package lsp-mode
  :commands (lsp lsp-deferred)
  :custom
  (lsp-keymap-prefix "C-c ;"))

;; Setting LSP-UI (show addition information)
(use-package lsp-ui
  :hook (lsp-mode . lsp-ui-mode))

;; Setting Auto-Competetion
(use-package company
  :after lsp-mode
  :hook (lsp-mode . company-mode)
  :custom
  (company-begin-commands '(self-insert-command))
  (company-idle-delay 0.5)
  (company-minimum-prefix-length 1)
  (company-show-quick-access t)
  (company-tooltip-align-annotations 't))

;; Setting Pyright
(use-package lsp-pyright
  :ensure t
  :hook (python-mode . (lambda ()
                          (require 'lsp-pyright)
                          (lsp))))  ;; or lsp-deferred

;;; .emacs ends here
