;;; Package --- Summary

;;; Package Commentary
;;; This Package is the initial file of my emcas configuration

;;; File:   ~/Dropbox/config/emacs/common/init.el

;;; Codes

(setq inhibit-startup-message t)
(setq ring-bell-function nil)
(tool-bar-mode -1)

;; Package management
(when (>= emacs-major-version 24)
  (require 'package)
  (setq package-archives '(
            ("org"       . "http://orgmode.org/elpa/")
			      ("gnu"       . "http://elpa.gnu.org/packages/")
			      ("melpa"     . "http://melpa.org/packages/")
			      ("milkbox" . "http://melpa.milkbox.net/packages/") 
			     ))
  (package-initialize)
)

;; Bootstrap `use-package'
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

;; UI and Fonts
(load-file "~/Dropbox/config/emacs/common/chinese.el")
;; Aliases 
(load-file "~/Dropbox/config/emacs/common/aliases.el")

;; Babel Load configuration files
(load-file "~/Dropbox/config/emacs/writer/init-main.el")

;; Start the server
;; Connect with emaclient
(when (string-equal system-type "gnu/linux")
 (unless (server-running-p) (server-start))
  )

;; First Open My work org file
(find-file "~/Dropbox/org/todo.org")
