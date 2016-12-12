(require 'package) ;; You might already have this line
(add-to-list 'package-archives
             '("melpa" . "http://melpa.org/packages/") t)
(when (< emacs-major-version 24)
  ;; For important compatibility libraries like cl-lib
  (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))
(package-initialize) ;; You might already have this line

;;(load-theme 'monokai t) ;;very good but too strong contrast
;;(load-theme 'seti t)
;;(load-theme 'spolsky t) ;;inspired by sublime default theme, too strong after a while I get annoyed
(load-theme 'solarized-dark t)

;; Set emacs background colour this should be the default bk color for seti theme
;;(set-background-color "#151718")

;;(set-cursor-color "#E6DB74")
(set-default 'cursor-type 'box)

;; disable startup screen
(setq inhibit-startup-message t)

;; binding home and end to begging and end of line
(global-set-key [home] 'move-beginning-of-line)
(global-set-key [end] 'move-end-of-line)

;;;;;;;;;;; Mode line themes and packages
;; enable powerline
;;(require 'powerline)
;;(powerline-default-theme)
;;(setq sml/theme ')
;;(sml/setup)
;;(require 'spaceline-config)
;;(spaceline-spacemacs-theme)
;;(spaceline-emacs-theme)




;; disable toolbar
(tool-bar-mode -1)
;; disable scrollbar
(scroll-bar-mode -1)

;;hopefully temporary: enable giude key
(setq guide-key/guide-key-sequence 't)
(guide-key-mode 1)

;; enable automatic auto-revert
(global-auto-revert-mode 1)


(require 'ace-jump-mode)
(define-key global-map (kbd "M-0") 'ace-jump-word-mode)
; this is for not input the head char for word move, this can case more key press
;(setq ace-jump-word-mode-use-query-char nil)
(global-set-key (kbd "M-p") 'ace-window)

;;(when (fboundp 'windmove-default-keybindings)
;;    (windmove-default-keybindings))
(global-set-key (kbd "s-<right>") 'windmove-right)
(global-set-key (kbd "s-<left>") 'windmove-left)
(global-set-key (kbd "s-<up>") 'windmove-up)
(global-set-key (kbd "s-<down>") 'windmove-down)

;; unset the list-buffers binding.
(global-unset-key (kbd "C-x C-b"))

(show-paren-mode 1)
(set-face-foreground 'show-paren-match "white") ;;showing the matching paren in the specific color
(set-face-attribute  'show-paren-match-face nil :weight 'extra-bold) ;;you can specify :height 130

(add-hook 'clojure-mode-hook 'paredit-mode)
(add-hook 'clojure-mode-hook 'company-mode)
(add-hook 'clojure-mode-hook 'turn-on-eldoc-mode)
(add-hook 'clojurescript-mode-hook 'turn-on-eldoc-mode)
(add-hook 'clojurescript-mode-hook 'company-mode)

;; disable auto-save
(setq auto-save-default nil)



;; scroll one line at a time (less "jumpy" than defaults)
(setq mouse-wheel-scroll-amount '(1 ((shift) . 1))) ;; one line at a time
(setq mouse-wheel-progressive-speed 't) ;; don't accelerate scrolling
(setq scroll-margin 1) ;; trigger the scrolling when I am on the last line

;; show line number
(global-linum-mode 1)

;;Expanding region hitting the bound char
;; c-= then use just = to expand, - to reduce 0 to reset and C-g to exit
(require 'expand-region)
(global-set-key (kbd "C-=") 'er/expand-region)

;;If enabled when a region is selected a new char delete the region
(delete-selection-mode 1)

;; to show file name when you press c-f6
(defun show-file-name ()
  "Show the full path file name in the minibuffer."
  (interactive)
  (message (buffer-file-name)))
(global-set-key [C-f6] 'show-file-name)

;; highlight tabs, spaces and empty line (at the beginning and end of file)
(setq
   whitespace-style '(face trailing tabs empty))
(global-whitespace-mode 1)

;; do not write tab
(setq-default indent-tabs-mode nil)

;; enable IDO InteractivelyDoThings
(require 'ido)
(ido-mode 1)
;; need it if you get TooBig error  (setq ido-max-directory-size 100000)

;;set backup folder and settings
(setq
   backup-by-copying t      ; don't clobber symlinks
   backup-directory-alist
    '(("." . "~/.emacsbackup"))    ; don't litter my fs tree
   delete-old-versions t
   kept-new-versions 3
   kept-old-versions 2
   version-control t)       ; use versioned backups

;; enable rainbow
(require 'rainbow-delimiters)
(add-hook 'prog-mode-hook 'rainbow-delimiters-mode)

;; easy way to highligt symbol under the curso and go throught the occurences
(require 'highlight-symbol)
(global-set-key [f5] 'highlight-symbol)
(global-set-key [(control f5)] 'highlight-symbol-next)
(global-set-key [(shift f5)] 'highlight-symbol-prev)
(global-set-key [(meta f5)] 'highlight-symbol-query-replace)


;;using the Figwheel REPL connected in emacs
(require 'cider)
(setq cider-cljs-lein-repl
      "(do (require 'figwheel-sidecar.repl-api)
           (figwheel-sidecar.repl-api/start-figwheel!)
           (figwheel-sidecar.repl-api/cljs-repl))")


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(highlight-symbol-colors
   (quote
    ("VioletRed1" "red1" "dark blue" "green3" "dark cyan" "purple4" "forest green")))
 '(highlight-symbol-foreground-color "gray100"))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 110 :width normal :foundry "nil" :family "Menlo"))))
 '(linum ((t (:foreground "orange1" :weight light :height 0.9))))
 '(rainbow-delimiters-depth-1-face ((t (:foreground "dark cyan"))))
 '(rainbow-delimiters-depth-2-face ((t (:foreground "dark magenta"))))
 '(rainbow-delimiters-depth-3-face ((t (:foreground "maroon1"))))
 '(rainbow-delimiters-depth-4-face ((t (:foreground "tomato1"))))
 '(rainbow-delimiters-depth-5-face ((t (:foreground "orange1"))))
 '(rainbow-delimiters-depth-6-face ((t (:foreground "gray57"))))
 '(rainbow-delimiters-depth-7-face ((t (:foreground "yellow1"))))
 '(rainbow-delimiters-depth-8-face ((t (:foreground "green1"))))
 '(rainbow-delimiters-depth-9-face ((t (:foreground "OrangeRed2")))))
