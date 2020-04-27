(require 'package) ;; You might already have this line
(add-to-list 'package-archives
             '("melpa" . "http://melpa.org/packages/") t)
(when (< emacs-major-version 24)
  ;; For important compatibility libraries like cl-lib
  (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))
(add-to-list 'load-path "~/.emacs.d/lisp/")
(package-initialize)
;; todo
;; check smex vs amx. Installed smex but probably better to use it as smex-major-mode-commands which is smex only for the major mode but smex gives more hints.
;; I think you need to try to use it
;; try to better understand why projectile open project is enable only with one project open and not from the beginning. is it related to where that project file is?
;; at the moment it is in the.emacs.d folder
;; load exec-path-from-shell for set the correct ENV path in MAC OS
(when (memq window-system '(mac ns))
  (exec-path-from-shell-initialize)
  (exec-path-from-shell-copy-env "GOPATH"))

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
;; misc
;; When running ‘projectile-switch-project’ (C-c p p), ‘neotree’ will change root automatically.
(setq projectile-switch-project-action 'neotree-projectile-action)

;;set backup folder and settings
(setq
   backup-by-copying t
   backup-directory-alist
    '(("." . "~/.emacsbackup"))
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

(require 'ag)
;; auto-revert if the file is updated by an external program
(global-auto-revert-mode 1)

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
	 ("<f12>" . lsp-ui-peek-find-references))
   )

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
  (go-eldoc-setup) ; it provides eldoc for go
  (use-package godoctor)
  (company-mode 1)
  (lsp-deferred) ; lsp will start only after the buffer is visible
  (company-quickhelp-mode 1)
  (flyspell-prog-mode)
  (add-hook 'before-save-hook 'whitespace-cleanup)
  (add-hook 'before-save-hook 'gofmt-before-save))
;; flycheck mode is enabled by default and all customisation I tried get ignored :(

(setenv "GOPATH" "/home/andrea/code/go")

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (use-package-chords key-chord frog-jump-buffer ace-jump ace-jump-mode expand-region smex ido-grid-mode ido-vertical-mode neotree which-key ag projectile godoctor smartparens spacemacs-theme solarized-theme solaire-mode lsp-ui flyspell-correct company-quickhelp company-lsp company go-scratch go-dlv go-eldoc go-playground go-guru flycheck lsp-mode go-mode))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
