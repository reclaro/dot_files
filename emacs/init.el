(require 'package) ;; You might already have this line
(add-to-list 'package-archives
             '("melpa" . "http://melpa.org/packages/") t)
(when (< emacs-major-version 24)
  ;; For important compatibility libraries like cl-lib
  (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))
(add-to-list 'load-path "/Users/androsa/.emacs.d/lisp/")
(package-initialize)

;; load exec-path-from-shell for set the correct ENV path in MAC OS
(when (memq window-system '(mac ns))
  (use-package exec-path-from-shell
    :ensure t)
  (exec-path-from-shell-initialize)
  (exec-path-from-shell-copy-env "GOPATH"))

(server-start)
;(setq debug-on-error t) ;; will enable debug frame on errors

;; disable startup screen
(setq inhibit-startup-message t)
;; disable auto-save
(setq auto-save-default nil)

;; scroll one line at a time (less "jumpy" than defaults)
(setq mouse-wheel-scroll-amount '(1 ((shift) . 1))) ;; one line at a time
(setq mouse-wheel-progressive-speed 't) ;; don't accelerate scrolling
(setq scroll-margin 1) ;; trigger the scrolling when I am on the last line

;; Look and Feel
(load-theme 'solarized-dark t)
;;(load-theme 'spacemacs-dark t)
(set-face-attribute 'default nil :height 110)

;spaceline with some fancy look & feel
(require 'spaceline-config)
(spaceline-emacs-theme)

;; show column number along with line number in the status bar
(setq column-number-mode t)
;; disable bars
(scroll-bar-mode -1)
(tool-bar-mode -1)
(require 'linum-highlight-current-line-number)

;(display-line-numbers-mode) ;; available from emacs 26
;; global  mapping
(global-set-key (kbd "M-,") 'pop-tag-mark)
(global-set-key [f8] 'neotree-toggle)
(global-set-key [f6] 'show-file-name)

;;windows move
(global-set-key (kbd "M-s-<right>") 'windmove-right)
(global-set-key (kbd "M-s-<left>") 'windmove-left)
(global-set-key (kbd "M-s-<up>") 'windmove-up)
(global-set-key (kbd "M-s-<down>") 'windmove-down)

;highlight
(global-set-key [f5] 'highlight-symbol)
(global-set-key [(control f5)] 'highlight-symbol-next)
(global-set-key [(shift f5)] 'highlight-symbol-prev)
(global-set-key [(meta f5)] 'highlight-symbol-query-replace)

;awesome-tab
; (global-set-key (kbd "s-t") 'awesome-tab-ace-jump) ; you use on linux with i3wm where the s- numbers binding doesn't work
(global-set-key (kbd "s-1") 'awesome-tab-select-visible-tab)
(global-set-key (kbd "s-2") 'awesome-tab-select-visible-tab)
(global-set-key (kbd "s-3") 'awesome-tab-select-visible-tab)
(global-set-key (kbd "s-4") 'awesome-tab-select-visible-tab)
(global-set-key (kbd "s-5") 'awesome-tab-select-visible-tab)
(global-set-key (kbd "s-6") 'awesome-tab-select-visible-tab)
(global-set-key (kbd "s-7") 'awesome-tab-select-visible-tab)
(global-set-key (kbd "s-8") 'awesome-tab-select-visible-tab)
(global-set-key (kbd "s-9") 'awesome-tab-select-visible-tab)
(global-set-key (kbd "s-0") 'awesome-tab-select-visible-tab)

;anzu
(global-set-key [remap query-replace] 'anzu-query-replace)
;; misc
;; When running ‘projectile-switch-project’ (C-c p p), ‘neotree’ will change root automatically.
(setq projectile-switch-project-action 'neotree-projectile-action)

;;set backup folder and settings
(setq
   backup-by-copying t
   backup-directory-alist
    '(("." . "/Users/androsa/.emacsbackup"))
   delete-old-versions t ; don't ask to delete excess backup versions
   kept-new-versions 3
   kept-old-versions 2
   version-control t); use version number for backups

;; to show file name
(defun show-file-name ()
  "Show the full path file name in the minibuffer."
  (interactive)
  (message (buffer-file-name)))

;; packages
(require 'company-lsp)
(push 'company-lsp company-backends)

;; auto-revert if the file is updated by an external program
(global-auto-revert-mode 1)


;; you might decide to activate all-the-icons for spaceline as well
;; it has some good mouse shortcut but I am not fully convinced of it

;; (use-package spaceline-all-the-icons
;;   :after spaceline
;;   :config (spaceline-all-the-icons-theme))

(use-package all-the-icons)
(use-package anzu
  :ensure t
  :config
  (global-anzu-mode 1))


(use-package  markdown-mode
  :config
  (add-hook 'markdown-mode-hook 'flyspell-mode))

(use-package ag
  :ensure t)

(use-package awesome-tab
  :load-path "/home/andrea/.emacs/lisp/awesome-tab"
  :config
  (awesome-tab-mode t)
  (setq awesome-tab-show-tab-index t)
  (setq awesome-tab-height 100)
  (setq awesome-tab-ace-keys (quote (49 50 51 52 53 54 55 56 57 48)))
  (setq awesome-tab-dark-active-bar-color nil)
  (setq awesome-tab-dark-selected-foreground-color "orange1"))
;  (setq awesome-tab-selected-face ((t (:background "#002b36" :foreground "orange1")))))

(use-package use-package-chords
  :ensure t
  :config (key-chord-mode 1))


(use-package frog-jump-buffer
  :ensure t
  :chords (("bn" . frog-jump-buffer-other-window)
	   ("bb" . frog-jump-buffer)))

(use-package ace-jump-mode
  :ensure t
  :config
  (ace-jump-mode-enable-mark-sync) ; doesn't seem to work
; if you want to highlight all word use this  (setq ace-jump-word-mode-use-query-char nil)
  :bind
  ("C-." . 'ace-jump-mode)
  ("C-:" . 'ace-jump-mode-pop-mark))
; that creates an autoload for ace-jump-mode command and defers loading until you use it

(use-package highlight-symbol
  :ensure t
  :config
  (setq highlight-symbol-colors ;if they are too bright use default ones
   (quote
    ("VioletRed1" "red1" "dark blue" "green3" "dark cyan" "purple4" "forest green")))
  (setq highlight-symbol-foreground-color "gray100"))

(use-package whitespace
  :ensure t
  :config
  (global-whitespace-mode 1)
  (setq whitespace-style '(face trailing empty)))

(use-package linum
  :ensure t
  :config
  (global-linum-mode t)
  (setq linum-format 'linum-highlight-current-line-number))

(use-package which-key
  :ensure t
  :config
  (which-key-mode 1)
  (setq which-key-show-early-on-C-h t);Allow C-h to trigger which-key before it is done automatically
  :init
  (which-key-setup-side-window-right-bottom))

(use-package projectile
  :ensure t
  :config
  (projectile-mode t)
  :bind
  (:map projectile-mode-map
	("C-c p" . projectile-command-map)))

(use-package smartparens
  :ensure t
  :config
  (smartparens-global-mode t)
  (show-smartparens-global-mode t))

(use-package ido-grid-mode
  :ensure t)

(use-package ido ;there is an alternative called flx-ido
  :ensure t
  :config
  (ido-mode 1)
  (ido-grid-mode 1) ; you can use ido-vertical-mode but in the grid-mode you can fit more data
  (setq ido-everywhere 1
	ido-enable-flex-matching t
        ido-grid-mode-padding " || "))

(use-package lsp-mode
   :ensure t
   :config
   (setq lsp-file-watch-threshold 3000) ; over the threshold it will ask for confirmation to watch files, default is set to 1000
   :hook ((go-mode . lsp))
   :commands lsp)

(use-package lsp-ui
   :ensure t
   :commands lsp-ui-mode
   :bind
   (:map lsp-ui-mode-map
	 ("<f12>" . lsp-ui-peek-find-references)))

(use-package go-mode
  :ensure t
  :init
  (setq company-idle-delay nil)
  (setq lsp-ui-doc-enable 1)
  (setq lsp-ui-doc-delay nil)
  (setq lsp-ui-doc-use-childframe 1)
  (setq lsp-ui-doc-position (quote top))
  (setq lsp-ui-sideline-enable nil)
  (setq lsp-ui-peek-enable 1)

  :bind
  (:map go-mode-map
	("M-SPC" . company-indent-or-complete-common)
	("C-c d" . lsp-ui-doc-show)
	("C-c t" . 'go-test-current-test)
	("C-c C-t" . 'go-test-current-file)
	("M-p" . 'compile))

  :config
  (use-package go-eldoc
   :ensure t
   :config
   (go-eldoc-setup)) ; it provides eldoc for go
 ; (use-package godoctor
  ;  :ensure t)
  (company-mode 1)
  (lsp-deferred) ; lsp will start only after the buffer is visible
  (company-quickhelp-mode 1)
  (flyspell-prog-mode)
  (add-hook 'before-save-hook 'whitespace-cleanup)
  (add-hook 'before-save-hook 'gofmt-before-save))
;; flycheck mode is enabled by default and all customisation I tried get ignored :(

(setenv "GOPATH" "/Users/androsa/code/go")

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(column-number-mode t)
 '(gnutls-algorithm-priority "normal:-vers-tls1.3")
 '(package-selected-packages
   (quote
    (paradox spaceline-all-the-icons anzu pomodoro spaceline all-the-icons-gnus yaml-mode load-theme-buffer-local color-theme-buffer-local magit flymake exec-path-from-shell let-alist use-package-chords key-chord frog-jump-buffer ace-jump ace-jump-mode expand-region smex ido-grid-mode ido-vertical-mode neotree which-key ag projectile godoctor smartparens spacemacs-theme solarized-theme solaire-mode lsp-ui flyspell-correct company-quickhelp company go-scratch go-dlv go-eldoc go-playground go-guru flycheck go-mode)))
 '(paradox-github-token t)
 '(tool-bar-mode nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
