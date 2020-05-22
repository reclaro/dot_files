(require 'package)
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
;; auto-revert mode
(setq global-auto-revert-mode t)
;; disable lock file
(setq create-lockfiles nil)
;; scroll one line at a time (less "jumpy" than defaults)
(setq mouse-wheel-scroll-amount '(1 ((shift) . 1))) ;; one line at a time
(setq mouse-wheel-progressive-speed 't) ;; don't accelerate scrolling
(setq scroll-margin 1) ;; trigger the scrolling when I am on the last line
;; enable delete on type for region
(delete-selection-mode 1)

;; Look and Feel
(load-theme 'solarized-dark t)
;;(load-theme 'spacemacs-dark t)
(set-face-attribute 'default nil :height 110)
(setq doom-themes-treemacs-theme "doom-colors") ; use the colorful treemacs theme
(doom-themes-treemacs-config)
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
(global-set-key [f8] 'treemacs)
(global-set-key [f6] 'show-file-name)
(global-set-key [remap zap-to-char] 'zop-to-char) ; zop-to-char is way better as it highlights the selection and gives more option
;; org-mode
(global-set-key (kbd "C-c l") 'org-store-link)
(global-set-key (kbd "C-c a") 'org-agenda)
(global-set-key (kbd "C-c c") 'org-capture)

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

(use-package use-package-chords
  :ensure t
  :config (key-chord-mode 1))


(defun my-org-mode-hook ()
  (setq fill-column 140)
  (auto-fill-mode t))

;; packages
(require 'company-lsp)
(push 'company-lsp company-backends)

;; auto-revert if the file is updated by an external program
(global-auto-revert-mode 1)
(global-flycheck-mode 1)
(global-whitespace-mode 1)
(yas-global-mode 1)
;; you might decide to activate all-the-icons for spaceline as well
;; it has some good mouse shortcut but I am not fully convinced of it

;; (use-package spaceline-all-the-icons
;;   :after spaceline
;;   :config (spaceline-all-the-icons-theme))

;; remove asterics for something more fancy
(use-package org-superstar
  :ensure t)

(use-package treemacs
  :ensure t
  :config
  (setq treemacs-single-click-expand-action t)
  (setq treemacs-space-between-root-nodes nil)
  ;(setq treemacs-no-png-images t) ;; disable icons
  )

(use-package treemacs-projectile
  :after treemacs projectile
  :ensure t)

(use-package treemacs-icons-dired
  :after treemacs dired
  :ensure t
  :config (treemacs-icons-dired-mode))

(use-package org
  :chords
   (("df" . org-toggle-time-stamp-overlays))

  :config
  (setq org-startup-indented t)
  (setq org-catch-invisible-edits 'error)
  (setq org-hide-emphasis-markers t)
  (setq org-M-RET-may-split-line (quote ((default)))) ;; M-RET in the middle of a line doesn't break the line
  (setq org-log-done 'time) ; set this per file as well
  (setq org-treat-S-cursor-todo-selection-as-state-change nil)
  ;(setq org-agenda-files (directory-files-recursively "~/Dropbox/org/" "\.org$"))
  (setq org-agenda-files (directory-files-recursively "~/Dropbox/org/" "\.txt$"))
  (setq org-time-stamp-custom-formats (quote ("<%d/%m/%y %a>" . "<%d/%m/%y %a %H:%M>")))
  (setq org-babel-load-languages
    (quote
    ((lisp . t)
     (python . t)
     (shell . t)
     (clojure . t)
     (java . t)
     (makefile . t))))
  (setq org-todo-keywords
	'((sequence "TODO(t)" "INPROGRESS(p)" "MEETING(m)" "TOREAD(r)" "TOWATCH(w)" "BLOCKED(b)"  "|" "DONE(d)" )
	  ))
  (setq org-todo-keyword-faces
   '(("MEETING" . "orange") ("INPROGRESS" . "Salmon") ("TOREAD" . "MediumPurple") ("TOWATCH" . "DeepSkyBlue4") ("BLOCKED" . "firebrick") | ("DONE" . "LimeGreen")))
   (add-hook 'org-mode-hook #'my-org-mode-hook)
   (add-hook 'org-mode-hook (lambda () (org-superstar-mode 1)))
   (add-hook 'before-save-hook 'whitespace-cleanup))

;; configuring integration with apt
(require 'appt)
(setq appt-time-msg-list nil)    ;; clear existing appt list
(setq appt-display-interval '5) ;; warn every 10 minutes from t - appt-message-warning-time
(setq
  appt-message-warning-time '15  ;; send first warning 10 minutes before appointment
  ;appt-display-mode-line nil     ;; don't show in the modeline
  appt-display-format 'window)   ;; pass warnings to the designated window function
(appt-activate 1)                ;; activate appointment notification
(display-time)                   ;; activate time display


(org-agenda-to-appt)             ;; generate the appt list from org agenda files on emacs launch
(run-at-time "06:30" 300 'org-agenda-to-appt)           ;; update appt list hourly
(add-hook 'org-finalize-agenda-hook 'org-agenda-to-appt) ;; update appt list on agenda view

;; set up the call to terminal-notifier
(defvar my-notifier-path
  "terminal-notifier")
(defun my-appt-send-notification (title msg)
  (shell-command (concat my-notifier-path " -message " msg " -title " title " -sound default" )))

;; designate the window function for my-appt-send-notification
(defun my-appt-display (min-to-app new-time msg)
  (my-appt-send-notification
   (if (string= min-to-app "0")
	(format "'Appointment NOW'")
	(format "'Appointment in %s minutes'" min-to-app))
    ;(format "'Appointment in %s minutes'" min-to-app)    ;; passed to -title in terminal-notifier call
    (format "'%s'" msg)))                                ;; passed to -message in terminal-notifier call
(setq appt-disp-window-function (function my-appt-display))

(use-package all-the-icons)
(use-package anzu
  :ensure t
  :config
  (global-anzu-mode 1))

(use-package flyspell
  :ensure t
  :hook ((org-mode markdown-mode) . flyspell-mode))

(use-package  markdown-mode
  :config
  (setq markdown-make-gfm-checkboxes-buttons nil))
;  (add-hook 'markdown-mode-hook 'flyspell-mode))

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



(use-package frog-jump-buffer
  :ensure t
  :config
  (setq frog-jump-buffer-include-current-buffer nil)
  (setq frog-jump-buffer-max-buffers 120)

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
  ;; :bind
  ;; (:map smartparens-mode-map
  ;; 	("M-<right>" . sp-forward-slurp-sexp) ; slurp move parenthesis
  ;; 	("M-<left>" . sp-backward-slurp-sexp)
  ;; 	("s-<right>" . sp-forward-barf-sexp) ; barf move word
  ;; 	("s-<left>" . sp-backward-barf-sexp)))

(define-key smartparens-mode-map (kbd "s-<right>") 'sp-forward-slurp-sexp)
(define-key smartparens-mode-map (kbd "s-<left>") 'sp-backward-slurp-sexp)
(define-key smartparens-mode-map (kbd "C-s-<right>") 'sp-forward-barf-sexp)
(define-key smartparens-mode-map (kbd "C-s-<left>") 'sp-backward-barf-sexp)

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
   (setq lsp-file-watch-threshold 100000) ; over the threshold it will ask for confirmation to watch files, default is set to 1000
   :hook ((go-mode . lsp))
   :commands lsp)

(use-package lsp-ui
   :ensure t
   :commands lsp-ui-mode
   :bind
   (:map lsp-ui-mode-map
	 ("<f12>" . lsp-ui-peek-find-references)))
;; Python configuration
(use-package elpy
  :ensure t
  :init
  (elpy-enable)
  :config
  (setq python-shell-interpreter "ipython"
      python-shell-interpreter-args "-i --simple-prompt"))

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
(add-to-list 'auto-mode-alist '("\\.txt\\'" . org-mode))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(column-number-mode t)
 '(custom-safe-themes
   (quote
    ("2809bcb77ad21312897b541134981282dc455ccd7c14d74cc333b6e549b824f3" "00445e6f15d31e9afaa23ed0d765850e9cd5e929be5e8e63b114a3346236c44c" "c433c87bd4b64b8ba9890e8ed64597ea0f8eb0396f4c9a9e01bd20a04d15d358" "7f1d414afda803f3244c6fb4c2c64bea44dac040ed3731ec9d75275b9e831fe5" default)))
 '(gnutls-algorithm-priority "normal:-vers-tls1.3")
 '(markdown-make-gfm-checkboxes-buttons nil)
 '(package-selected-packages
   (quote
    (zop-to-char elpy doom-themes kaolin-themes treemacs-icons-dired treemacs-projectile treemacs org-superstar paradox spaceline-all-the-icons anzu spaceline all-the-icons-gnus yaml-mode load-theme-buffer-local color-theme-buffer-local magit flymake exec-path-from-shell let-alist use-package-chords key-chord frog-jump-buffer ace-jump ace-jump-mode expand-region smex ido-grid-mode ido-vertical-mode which-key ag projectile godoctor smartparens spacemacs-theme solarized-theme solaire-mode lsp-ui flyspell-correct company-quickhelp company go-scratch go-dlv go-eldoc go-playground go-guru flycheck go-mode)))
 '(paradox-github-token t)
 '(recentf-mode t)
 '(tool-bar-mode nil)
 '(treemacs-fringe-indicator-mode t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(linum ((t (:background "#002b36" :foreground "#586e75" :underline nil :weight thin :height 100))))
 '(org-checkbox ((t (:background "#002b36" :foreground "#839496" :box nil)))))
