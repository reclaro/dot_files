(require 'package)
(add-to-list 'package-archives
'("melpa" . "https://melpa.org/packages/") t)
(when (< emacs-major-version 24)
  ;; For important compatibility libraries like cl-lib
  (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))
(add-to-list 'load-path "/home/andrea/.emacs.d/lisp/")
(package-initialize)

;; load exec-path-from-shell for set the correct ENV path in MAC OS
(when (memq window-system '(mac ns))
  (use-package exec-path-from-shell
    :ensure t)
  (exec-path-from-shell-initialize)
  (exec-path-from-shell-copy-env "GOPATH"))

(require 'cl-lib)
(server-start)
;(setq debug-on-error t) ;; will enable debug frame on errors
;;(setq debug-on-quit t) ;; CTROL G to see the dump

;; confirm before leaving, making a lot of confusion witn C-c x for org-mode so safer to ask before leaving
(setq confirm-kill-emacs (quote y-or-n-p))
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

(powerline-center-theme)
;; Look and Feel
(require 'doom-themes)
;;(load-theme 'solarized-dark t)
(load-theme 'doom-solarized-dark t) ;; require to install doom-themes package
;(load-theme 'solarized-dark-high-contrast t)
;;(load-theme 'spacemacs-dark t)
(set-face-attribute 'default nil :height 110)
;; note that if the dimension of the line number is different you might have problems with
;; the position of the cursor, as it points to a line that it is not the one you want.
;; keep the same value for font and line font seems to do the trick
(eval-after-load "linum"
  '(set-face-attribute 'linum nil :height 100))
(setq doom-themes-treemacs-theme "doom-colors") ; use the colorful treemacs theme
(doom-themes-treemacs-config)
;spaceline with some fancy look & feel
(require 'spaceline-config)
(require 'linum-highlight-current-line-number)

;(spaceline-emacs-theme)
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ivy-posframe ((t (:foreground "gray82"))))
 '(linum ((t (:background "#002b36" :foreground "#586e75" :underline nil :weight thin :height 90))))
 '(org-checkbox ((t (:background "#002b36" :foreground "#839496" :box nil))))
 '(org-level-1 ((t (:inherit variable-pitch :foreground "purple" :height 1.3))))
 '(region ((t (:background "dark cyan" :foreground "Yellow")))))

;; show column number along with line number in the status bar
(setq column-number-mode t)
;; disable bars
(scroll-bar-mode -1)
(tool-bar-mode -1)
(setenv "GOPATH" "/home/andrea/code/go")

;(display-line-numbers-mode) ;; available from emacs 26
;; global  mapping
(global-set-key (kbd "M-,") 'pop-tag-mark)
(global-set-key [f8] 'treemacs)
(global-set-key [f6] 'show-file-name)
(global-set-key [remap zap-to-char] 'zop-up-to-char) ; zop-to-char is way better as it highlights the selection and gives more option
;; org-mode
(global-set-key (kbd "C-c l") 'org-store-link)
(global-set-key (kbd "C-c a") 'org-agenda)
(global-set-key (kbd "C-c c") 'counsel-org-capture)


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


;;multiple-cursors
(global-set-key (kbd "C-M-j") 'mc/mark-all-dwim)
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)

;awesome-tab
;; (global-set-key (kbd "s-1") 'awesome-tab-select-visible-tab)
;; (global-set-key (kbd "s-2") 'awesome-tab-select-visible-tab)
;; (global-set-key (kbd "s-3") 'awesome-tab-select-visible-tab)
;; (global-set-key (kbd "s-4") 'awesome-tab-select-visible-tab)
;; (global-set-key (kbd "s-5") 'awesome-tab-select-visible-tab)
;; (global-set-key (kbd "s-6") 'awesome-tab-select-visible-tab)
;; (global-set-key (kbd "s-7") 'awesome-tab-select-visible-tab)
;; (global-set-key (kbd "s-8") 'awesome-tab-select-visible-tab)
;; (global-set-key (kbd "s-9") 'awesome-tab-select-visible-tab)
;; (global-set-key (kbd "s-0") 'awesome-tab-select-visible-tab)

;anzu
(global-set-key [remap query-replace] 'anzu-query-replace)

;;set backup folder and settings
(setq
   backup-by-copying t
   backup-directory-alist
    '(("." . "/home/andrea/.emacsbackup"))
   delete-old-versions t ; don't ask to delete excess backup versions
   kept-new-versions 3
   kept-old-versions 2
   version-control t); use version number for backups


;; This needs to be set-up before org is loaded
 (setq org-enforce-todo-checkbox-dependencies t)

;; Disable the suspend-frame command.
;; (global-unset-key (kbd "C-z"))
(global-set-key (kbd "C-z") 'undo)
;; to show file name
(defun show-file-name ()
  "Show the full path file name in the minibuffer."
  (interactive)
  (message (buffer-file-name)))

(use-package treemacs
  :ensure t
  :defer t
  :bind(
  :map treemacs-mode-map
  ([mouse-1] . treemacs-single-click-expand-action))
  :config
  (progn
    (setq treemacs-single-click-expand-action t
	  treemacs-space-between-root-nodes nil )
    (treemacs-fringe-indicator-mode nil))
  )

;(define-key treemacs-mode-map [mouse-1] #'treemacs-single-click-expand-action)

(use-package ace-window
  :bind ("M-o" . ace-window)
  :custom
  (aw-scope 'frame)
  (aw-dispatch-always t)
  (aw-dispatch-alist
   '((?s aw-swap-window "Swap window")
     (?h aw-split-window-vert "Split vertical")
     (?v aw-split-window-horz "Split horizontally")
     (?? aw-show-dispatch-help)
     (?= aw-split-window-fair "Split Fair window")
     (?b aw-flip-window)
     (?d aw-delete-window "Delete window"))
   (aw-display-mode-overlay t)
   (aw-ignore-current nil)
   (aw-minibuffer-flag t))
  :config (ace-window-display-mode 0))

(use-package use-package-chords
  :ensure t
  :config (key-chord-mode 1))


(defun my-org-mode-hook ()
  (setq fill-column 140)
  (auto-fill-mode t))

;; packages
;; CANT find(require 'company-lsp)
;;(push 'company-lsp company-backends)

(use-package flycheck
  :ensure t
  :init (global-flycheck-mode))
;; auto-revert if the file is updated by an external program
(global-auto-revert-mode 1)
;(global-flycheck-mode 1)
(global-whitespace-mode 1)
(require 'yasnippet)
(yas-global-mode 1)
;; you might decide to activate all-the-icons for spaceline as well
;; it has some good mouse shortcut but I am not fully convinced of it

;; (use-package spaceline-all-the-icons
;;   :after spaceline
;;   :config (spaceline-all-the-icons-theme))

;; remove asterics for something more fancy
(use-package org-superstar
  :ensure t)

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
  (setq org-agenda-start-on-weekday 1) ; start the week on monday
  (setq org-catch-invisible-edits 'error)
  (setq org-hide-emphasis-markers t)
  (setq org-M-RET-may-split-line (quote ((default)))) ;; M-RET in the middle of a line doesn't break the line
  (setq org-log-done 'time) ; set this per file as well
  (setq org-log-reschedule (quote note)) ; when a task is rescheduled add a note
  (setq org-treat-S-cursor-todo-selection-as-state-change nil)
  (setq org-enforce-todo-dependencies t)
;  (setq org-image-actual-width (quote (0)))
;;					;   (setq org-image-actual-width '(300)) require imagemagick support
  (setq org-cycle-separator-lines 0)
  (setq org-use-speed-commands t)
  (setq org-speed-commands-user (quote (("-" . widen) ("+" . org-narrow-to-subtree) ("j" . counsel-org-goto))))
  (setq org-outline-path-complete-in-steps nil)
  (setq org-refile-use-outline-path 'file)
  (setq org-refile-allow-creating-parent-nodes 'confirm)
  (setq org-refile-targets (quote (("~/roz/org/readwatch.txt" :maxlevel . 1)
				   (buffer-file-name :maxlevel . 9)
				   (org-agenda-files :maxlevel . 9)
;				   ("~/Dropbox/org/workbook.txt" :maxlevel . 9)
				   )))
  ;;(setq org-agenda-files (directory-files-recursively "~/Dropbox/org/" "\.txt$"))
  (setq all-files (directory-files "~/roz/org/" t "\.txt$"))
  (setq exclude-from-agenda (list "/home/andrea/roz/org/homeschooling.txt" )) ;; add to the list file you want to esclude
  (setq org-agenda-file (cl-set-difference all-files exclude-from-agenda :test 'equal))

  (setq org-time-stamp-custom-formats (quote ("<%d/%m/%y %a>" . "<%d/%m/%y %a %H:%M>")))

  (setq org-babel-load-languages
    (quote
    ((lisp . t)
     (python . t)
     (shell . t)
     (golang . t)
     (clojure . t)
     (java . t)
     (makefile . t))))
  (setq org-todo-keywords
	'(
	  (sequence "TODO(t)" "INPROGRESS(i)" "MEETING(m)" "PAUSED(p@)" "BLOCKED(b@)" "INREVIEW(v)"  "|" "DONE(d)" )
	  (sequence "TODO(t)" "TOREAD(r)" "TOWATCH(w)" "|" "DONE(d)")
	  ))
  (setq org-todo-keyword-faces
   '(("TODO" . "DarkCyan") ("MEETING" . "yellow") ("INPROGRESS" . "Salmon") ("TOREAD" . "MediumPurple") ("TOWATCH" . "orchid2") ("INREVIEW" . "limeGreen") ("PAUSED" . "magenta") ("BLOCKED" . "firebrick") | ("DONE" . "MistyRose4")))
   (add-hook 'org-mode-hook #'my-org-mode-hook)
   (add-hook 'org-mode-hook (lambda () (org-superstar-mode 1)))
   (add-hook 'before-save-hook 'whitespace-cleanup))

;; configuring integration with apt
(require 'appt)
(setq appt-time-msg-list nil)    ;; clear existing appt list
(setq appt-display-interval '10) ;; warn every 10 minutes from t - appt-message-warning-time
(setq
  appt-message-warning-time '15  ;; send first warning 10 minutes before appointment
  ;appt-display-mode-line nil     ;; don't show in the modeline
  appt-display-format 'window)   ;; pass warnings to the designated window function
(appt-activate 1)                ;; activate appointment notification
(display-time)                   ;; activate time display


(org-agenda-to-appt)             ;; generate the appt list from org agenda files on emacs launch
(run-at-time "06:30" 600 'org-agenda-to-appt)           ;; update appt list every 10 minutes
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

;;org-capture template
(setq org-capture-templates
      '(
	("t" "New Task in the workbook" entry (file+olp+datetree "~/roz/org/workbook.txt")
	 "* %^{Title}\n%i%?")
	 ("j" "Journal meeting entry" plain (function org-journal-find-location)
	  "** %(format-time-string org-journal-time-format)%^{MeetingTitle}\n%i%?")
	 ("l" "Read and watch list" entry (file "~/roz/org/readwatch.txt")
	  "* TODO %i%?")
	 ("b" "Enter Book entry" entry (file "~/roz/books.txt")
	  "* %^{TITOLO}\n:PROPERTIES:\n:GENERE: %^{genere}\n:PAGINE: %^{pagine}\n:LINGUA: %^{|ITA|ENG|}\n:INIZIATO: %<%d-%m-%Y>\n:FINITO: %<%d-%m-%Y>\n:FORMATO: %^{|Cartaceo|kindle|pdf|audio|altro|}\n:END:\nAutore: %^{Autore}\nConsigliato da: %^{consigliato da}\nValutazione (1..5): %^{Valutazione|1|2|3|4|5|}\nNote: %^{Note}\n** Commento:\n%?")
	 ))

(defun org-journal-find-location ()
  ;; Open today's journal, but specify a non-nil prefix argument in order to
  ;; inhibit inserting the heading; org-capture will insert the heading.
  (newline)
  (org-journal-new-entry t)

  ;; Position point on the journal's top-level heading so that org-capture
  ;; will add the new entry as a child entry.
  (goto-char (point-max)))


(setq lsp-go-env '((GOFLAGS . "-tags=unit,integration,echo,uncategorised,recall,payment_admission,payment_submission,scheme_messages,return_admission,reports,signonpayment_submission,signon")))


(use-package org-journal
  :ensure t
  :defer t
  :config
  (setq org-journal-enable-agenda-integration t)
  :custom
  (org-journal-dir "~/org/journal/")
  )


;; Drag-and-drop images from web or from capture
(use-package org-download
  :ensure t
  :defer t
  :after org
  :config
  (org-download-enable)
  (setq org-download-backend "curl \"%s\" -o \"%s\"")
  (setq org-download-screenshot-method "screencapture -i %s")
  (setq org-download-image-dir "~/roz/images"))
;; too much I don't like icons in the mini-buffer
;; (use-package all-the-icons-ivy
;;   :ensure t
;;   :init (add-hook 'after-init-hook 'all-the-icons-ivy-setup))

(use-package all-the-icons)

(use-package flyspell
  :ensure t
  :hook ((org-mode markdown-mode) . flyspell-mode))

(use-package markdown-mode
  :config
  (setq markdown-make-gfm-checkboxes-buttons nil))
;  (add-hook 'markdown-mode-hook 'flyspell-mode))

;configuartion for Titlfile
;; (use-package bazel :ensure t)
;; (add-to-list 'auto-mode-alist '("Tiltfile.*" . bazel-starlark-mode))
;; ;; enable LSP server with Tiltfiles
;; (add-to-list 'lsp-lanuage-id-configuration '(bazel-starlark-mode . "starlark"))
;; (lsp-register-client
;;  (make-lsp-client :new-connection (lsp-stdio-connection '("tilt" "lsp" "start"))
;;		  :activation-fn (lsp-activate-on "starlark")
;;		  :server-id 'tilt))

(use-package ag
  :ensure t)

;; (use-package awesome-tab
;;   :load-path "/home/andrea/.emacs/lisp/awesome-tab"
;;   :config
;;   (awesome-tab-mode t)
;;   (setq awesome-tab-show-tab-index t)
;;   (setq awesome-tab-height 100)
;;   (setq awesome-tab-ace-keys (quote (49 50 51 52 53 54 55 56 57 48)))
;;   (setq awesome-tab-dark-active-bar-color nil)
;;   (setq awesome-tab-dark-selected-foreground-color "orange1"))
;  (setq awesome-tab-selected-face ((t (:background "#002b36" :foreground "orange1")))))
(use-package frog-jump-buffer
  :ensure t
  :config
  (setq frog-jump-buffer-include-current-buffer nil)
  (setq frog-jump-buffer-max-buffers 120)

  :chords (("zn" . frog-jump-buffer-other-window)
	   ("zb" . frog-jump-buffer)))
(use-package avy
  :ensure t
  :chords (("jj" . avy-goto-word-1)
	   ("jw" . avy-goto-word-0)
	   ("jc" . avy-goto-char-timer)))

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
  (which-key-setup-side-window-bottom))

(use-package projectile
  :ensure t
  :config
  (projectile-mode t)
  (setq projectile-completion-system 'ivy)
  :chords ("zf" . projectile-find-file )
  :bind
  (:map projectile-mode-map
	("C-c p" . projectile-command-map)))

(use-package smartparens
  :ensure t
  :config
  (smartparens-global-mode t)
  (show-smartparens-global-mode t))

(define-key smartparens-mode-map (kbd "s-]") 'sp-forward-slurp-sexp)
(define-key smartparens-mode-map (kbd "s-[") 'sp-backward-slurp-sexp)
(define-key smartparens-mode-map (kbd "s-}") 'sp-forward-barf-sexp)
(define-key smartparens-mode-map (kbd "s-{") 'sp-backward-barf-sexp)



(use-package go-dlv
  :ensure t
  :bind
  (("C-c p" . dlv-current-func)))

(use-package lsp-mode
   :ensure t
   :config
   (setq lsp-file-watch-threshold 100000) ; over the threshold it will ask for confirmation to watch files, default is set to 1000
   (setq lsp-headerline-breadcrumb-enable nil)
   (define-key lsp-mode-map (kbd "C-<tab> ") lsp-command-map)
   :hook ((go-mode . lsp))
   :commands lsp)

(with-eval-after-load 'lsp-mode'
  (add-hook 'lsp-mode-hook #'lsp-enable-which-key-integration))

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


(use-package vertico
  :ensure t
  :custom
  (vertico-cycle t)
  :init
  (vertico-mode))

(use-package vertico-posframe
  :ensure t
  :init
  (vertico-posframe-mode))



(use-package marginalia
  :ensure t
  :init
  (marginalia-mode))

(use-package embark
  :ensure t
  :bind
  (("C-." . embark-act)
   ("C-h B" . embark-bindings)))

;; (use-package embark-consult
;;   :ensure t
;;   :hook
;;   (embark-collect-mode . consult-preview-at-point-mode))

(use-package popper
  :ensure t
  :bind (("M-p" . popper-toggle-latest)
	 ("M-`" . popper-cycle)
	 ("C-M-`" . popper-toggle-type))
  :init
  (setq popper-reference-buffers
	`("\\*Messages\\*"
	  "Output\\*$"
	  "\\*Async shell Command"
	  help-mode
	  compilation-mode))
  (popper-mode +1)
  (popper-echo-mode +1))



(use-package orderless
  :ensure t
  :custom
  (completion-styles '(orderless basic))
  (completion-category-overrides '((file (styles basic partial-completion)))))


;; I want to use M-c as leader for specific consult command so I unsed the capitalize work function
(global-unset-key (kbd "M-c"))
(use-package consult
  :ensure t
  :bind
  (("C-s" . consult-line)
   ("C-x b" . consult-buffer)
   ("C-x s" . consult-line)
   ("M-g g" . consult-goto-line)
   ("M-c f" . consult-find)
   ("M-c p b" . consult-project-buffer)
   ("M-c g" . consult-ripgrep)
   ("C-c j" . consult-org-heading)
   ))

(defun go-test-current-test-no-cache ()
  (interactive)
  (setq current-prefix-arg '1)
  (go-test-current-test))

(use-package go-mode
  :ensure t
  :init
  (setq company-idle-delay 0)
  (setq lsp-ui-doc-enable 1) ;; it was 1
  (setq lsp-ui-doc-delay 1)
  (setq lsp-ui-doc-use-childframe 1) ;; it was 1
  (setq lsp-ui-doc-position (quote top))
  (setq lsp-ui-sideline-enable 1) ;; it was nil
  (setq lsp-ui-peek-enable 1) ; it was 1
;  (setq gofmt-command "gofmt")
    (setq gofmt-command "goimports")

  :bind
  (:map go-mode-map
					;	("M-SPC" . company-indent-or-complete-common)
	("M-SPC" . company-complete-common)
	("C-c d" . lsp-ui-doc-show)
	("C-c t" . 'go-test-current-test-no-cache) ;; require package gotest run test with custom fn to disable cache
	;; orig("C-c t" . 'go-test-current-test) ;; require package gotest
	("C-c C-t" . 'go-test-current-file))

  :config
  ;; (use-package go-eldoc
  ;;    :ensure t
  ;;    :config
  ;;    (go-eldoc-setup))
					; it provides eldoc for go
  (use-package godoctor
    :ensure t)
  (company-mode 1)
  (lsp-deferred) ; lsp will start only after the buffer is visible
;  (company-quickhelp-mode 1)
  (flyspell-prog-mode)
  (add-hook 'before-save-hook 'whitespace-cleanup)
 ; (add-hook 'before-save-hook 'goimports)
  (add-hook 'before-save-hook 'gofmt-before-save))


;; this treats txt file as org files
(add-to-list 'auto-mode-alist '("\\.txt\\'" . org-mode))

;; Export org files to reveal.js presentations
(use-package ox-reveal :ensure t)
(load-library "ox-reveal")
(use-package htmlize :ensure t) ; required for source block highlighting

(use-package terraform-mode
  :ensure t
  )


(setq org-emphasis-alist
  '(("*" (bold :foreground "Orange" ))
    ("/" italic)
    ("_"  (:background "maroon" :foreground "white"))
    ("=" org-verbatim verbatim)
    ("~" org-code verbatim)
  ;  ("~" (:background "deep sky blue" :foreground "MidnightBlue"))
    ("+" (:strike-through t))))


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(column-number-mode t)
 '(compilation-message-face 'default)
 '(cua-global-mark-cursor-color "#00ad9c")
 '(cua-normal-cursor-color "#474747")
 '(cua-overwrite-cursor-color "#c49700")
 '(cua-read-only-cursor-color "#1d9700")
 '(custom-safe-themes
   '("636b135e4b7c86ac41375da39ade929e2bd6439de8901f53f88fde7dd5ac3561" "0c08a5c3c2a72e3ca806a29302ef942335292a80c2934c1123e8c732bb2ddd77" "efcecf09905ff85a7c80025551c657299a4d18c5fcfedd3b2f2b6287e4edd659" "d89e15a34261019eec9072575d8a924185c27d3da64899905f8548cbd9491a36" "833ddce3314a4e28411edf3c6efde468f6f2616fc31e17a62587d6a9255f4633" "3e200d49451ec4b8baa068c989e7fba2a97646091fd555eca0ee5a1386d56077" "9b01a258b57067426cc3c8155330b0381ae0d8dd41d5345b5eddac69f40d409b" "a70b47c87e9b0940f6fece46656200acbfbc55e129f03178de8f50934ac89f58" "d71aabbbd692b54b6263bfe016607f93553ea214bc1435d17de98894a5c3a086" "e964832f274625fa45810c688bdbe18caa75a5e1c36b0ca5ab88924756e5667f" "76bfa9318742342233d8b0b42e824130b3a50dcc732866ff8e47366aed69de11" "bc836bf29eab22d7e5b4c142d201bcce351806b7c1f94955ccafab8ce5b20208" "285efd6352377e0e3b68c71ab12c43d2b72072f64d436584f9159a58c4ff545a" "229c5cf9c9bd4012be621d271320036c69a14758f70e60385e87880b46d60780" "51ec7bfa54adf5fff5d466248ea6431097f5a18224788d0bd7eb1257a4f7b773" "830877f4aab227556548dc0a28bf395d0abe0e3a0ab95455731c9ea5ab5fe4e1" "1526aeed166165811eefd9a6f9176061ec3d121ba39500af2048073bea80911e" "1d50bd38eed63d8de5fcfce37c4bb2f660a02d3dff9cbfd807a309db671ff1af" "2809bcb77ad21312897b541134981282dc455ccd7c14d74cc333b6e549b824f3" "00445e6f15d31e9afaa23ed0d765850e9cd5e929be5e8e63b114a3346236c44c" "c433c87bd4b64b8ba9890e8ed64597ea0f8eb0396f4c9a9e01bd20a04d15d358" "7f1d414afda803f3244c6fb4c2c64bea44dac040ed3731ec9d75275b9e831fe5" default))
 '(gnutls-algorithm-priority "normal:-vers-tls1.3")
 '(highlight-changes-colors '("#d33682" "#6c71c4"))
 '(highlight-symbol-colors
   '("#f6fbe499c5cf" "#cf84ebcde648" "#ffffcbf4bf1f" "#e2f7d2f3f6c2" "#cebae658c3df" "#fef6d2e3bff6" "#d496d634fa81"))
 '(highlight-symbol-foreground-color "#282828")
 '(highlight-tail-colors
   '(("#073642" . 0)
     ("#5b7300" . 20)
     ("#007d76" . 30)
     ("#0061a8" . 50)
     ("#866300" . 60)
     ("#992700" . 70)
     ("#a00559" . 85)
     ("#073642" . 100)))
 '(hl-bg-colors
   '("#866300" "#992700" "#a7020a" "#a00559" "#243e9b" "#0061a8" "#007d76" "#5b7300"))
 '(hl-fg-colors
   '("#002b36" "#002b36" "#002b36" "#002b36" "#002b36" "#002b36" "#002b36" "#002b36"))
 '(hl-paren-colors '("#2aa198" "#b58900" "#268bd2" "#6c71c4" "#859900"))
 '(lsp-ui-doc-border "#282828")
 '(markdown-command "/usr/bin/pandoc")
 '(markdown-make-gfm-checkboxes-buttons nil)
 '(markdown-open-command "/usr/bin/pandoc")
 '(nrepl-message-colors
   '("#dc322f" "#cb4b16" "#b58900" "#5b7300" "#b3c34d" "#0061a8" "#2aa198" "#d33682" "#6c71c4"))
 '(org-agenda-files
   '("/home/andrea/roz/org/beorg.txt" "/home/andrea/roz/org/billbook.txt" "/home/andrea/roz/org/readwatch.txt" "/home/andrea/roz/org/workbook.txt"))
 '(org-image-actual-width '(0))
 '(org-journal-date-format "%A, %d %B %Y" nil nil "Customized with use-package org-journal")
 '(org-journal-file-format "%Ymeeting.txt")
 '(org-journal-file-type 'yearly)
 '(org-use-speed-commands t)
 '(package-selected-packages
   '(git-link org-cliplink kubernetes dockerfile-mode ox-reveal org-re-reveal k8s-mode mermaid-mode multiple-cursors popper embark embark-consult bazel gotest consult marginalia orderless neotree rainbow-delimiters company-shell lsp-mode uuidgen treemacs-all-the-icons go ivy-posframe avy org-roam org-sidebar company-terraform terraform-doc terraform-mode org-download popwin all-the-icons-ivy counsel ivy org-journal zop-to-char elpy doom-themes kaolin-themes treemacs-icons-dired treemacs-projectile treemacs org-superstar paradox spaceline-all-the-icons anzu spaceline all-the-icons-gnus yaml-mode load-theme-buffer-local color-theme-buffer-local magit flymake exec-path-from-shell let-alist use-package-chords key-chord frog-jump-buffer ace-jump ace-jump-mode expand-region smex ido-grid-mode ido-vertical-mode which-key ag projectile godoctor smartparens spacemacs-theme solarized-theme solaire-mode lsp-ui flyspell-correct company-quickhelp company go-scratch go-dlv go-eldoc go-playground go-guru flycheck go-mode))
 '(paradox-github-token t)
 '(pos-tip-background-color "#073642")
 '(pos-tip-foreground-color "#93a1a1")
 '(recentf-mode t)
 '(smartrep-mode-line-active-bg (solarized-color-blend "#859900" "#073642" 0.2))
 '(term-default-bg-color "#002b36")
 '(term-default-fg-color "#839496")
 '(tool-bar-mode nil)
 '(treemacs-fringe-indicator-mode t)
 '(vc-annotate-background-mode nil)
 '(weechat-color-list
   '(unspecified "#002b36" "#073642" "#a7020a" "#dc322f" "#5b7300" "#859900" "#866300" "#b58900" "#0061a8" "#268bd2" "#a00559" "#d33682" "#007d76" "#2aa198" "#839496" "#657b83"))
 '(xterm-color-names
   ["#073642" "#dc322f" "#859900" "#b58900" "#268bd2" "#d33682" "#2aa198" "#eee8d5"])
 '(xterm-color-names-bright
   ["#002b36" "#cb4b16" "#586e75" "#657b83" "#839496" "#6c71c4" "#93a1a1" "#fdf6e3"]))
