(require 'package) ;; You might already have this line
(add-to-list 'package-archives
             '("melpa" . "http://melpa.org/packages/") t)
(when (< emacs-major-version 24)
  ;; For important compatibility libraries like cl-lib
  (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))
(add-to-list 'load-path "/Users/androsa/.emacs.d/lisp/")
;;(package-initialize)
;; todo
;; check smex vs amx. Installed smex but probably better to use it as smex-major-mode-commands which is smex only for the major mode but smex gives more hints.
;; I think you need to try to use it
;; try to better understand why projectile open project is enable only with one project open and not from the beginning. is it related to where that project file is?
;; at the moment it is in the.emacs.d folder
;; load exec-path-from-shell for set the correct ENV path in MAC OS
(when (memq window-system '(mac ns))
  (exec-path-from-shell-initialize)
  (exec-path-from-shell-copy-env "GOPATH"))


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
(load-theme 'tango-dark t)

; (display-line-numbers-mode 1)
(global-display-line-numbers-mode 1)
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:background nil)))))
