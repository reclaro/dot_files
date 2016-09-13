(require 'package) ;; You might already have this line
(add-to-list 'package-archives
             '("melpa" . "http://melpa.org/packages/") t)
(when (< emacs-major-version 24)
  ;; For important compatibility libraries like cl-lib
  (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))
(package-initialize) ;; You might already have this line

;;(load-theme 'monokai t) ;;very good but too strong contrast
(load-theme 'seti t)

;; Set emacs background colour this should be the default bk color for seti theme
;; (set-background-color "#151718")

(set-cursor-color "#E6DB74")
(set-default 'cursor-type 'box)

;; disable startup screen
(setq inhibit-startup-message t)

;; enable powerline
(require 'powerline)
(powerline-default-theme)
;; disable toolbar
(tool-bar-mode -1)
;; disable scrollbar
(scroll-bar-mode -1)

;; enable automatic auto-revert
(global-auto-revert-mode 1)

;;(when (fboundp 'windmove-default-keybindings)
;;    (windmove-default-keybindings))

;;(auto-complete-mode 1)
(show-paren-mode 1)


(add-hook 'clojure-mode-hook 'paredit-mode)
;;(add-hook 'clojurescript-mode-hook 'show-paren-mode)
;;(add-hook 'clojurescript-mode-hook 'auto-complete-mode)

;; disable auto-save
(setq auto-save-default nil)

;; scroll one line at a time (less "jumpy" than defaults)
(setq mouse-wheel-scroll-amount '(1 ((shift) . 1))) ;; one line at a time
(setq mouse-wheel-progressive-speed nil) ;; don't accelerate scrolling
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
