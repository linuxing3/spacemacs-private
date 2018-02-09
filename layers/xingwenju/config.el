;; make frequently used commands short
(defalias 'qrr 'query-replace-regexp)
(defalias 'lml 'list-matching-lines)
(defalias 'dml 'delete-matching-lines)
(defalias 'dnml 'delete-non-matching-lines)
(defalias 'dtw 'delete-trailing-whitespace)
(defalias 'sl 'sort-lines)
(defalias 'rr 'reverse-region)
(defalias 'rs 'replace-string)

(defalias 'g 'grep)
(defalias 'gf 'grep-find)
(defalias 'fd 'find-dired)

(defalias 'rb 'revert-buffer)

(defalias 'sh 'shell)
(defalias 'fb 'flyspell-buffer)
(defalias 'sbc 'set-background-color)
(defalias 'rof 'recentf-open-files)
(defalias 'lcd 'list-colors-display)
(defalias 'cc 'calc)

					; elisp
(defalias 'eb 'eval-buffer)
(defalias 'er 'eval-region)
(defalias 'ed 'eval-defun)
(defalias 'eis 'elisp-index-search)
(defalias 'lf 'load-file)

					; major modes
(defalias 'hm 'html-mode)
(defalias 'css 'css-mode)
(defalias 'web 'web-mode)
(defalias 'tm 'text-mode)
(defalias 'elm 'emacs-lisp-mode)
(defalias 'om 'org-mode)
(defalias 'ssm 'shell-script-mode)

					; minor modes
(defalias 'wsm 'whitespace-mode)
(defalias 'gwsm 'global-whitespace-mode)
(defalias 'vlm 'visual-line-mode)
(defalias 'glm 'global-linum-mode)
(defalias 'gcm 'global-company-mode)

;; files
(defalias 'inbox 'gtd)
(defalias 'office 'work)
(defalias 'daniel 'kid)

;; define constants
(defconst sys/win32p
  (eq system-type 'windows-nt)
  "Are we running on a WinTel system?")

(defconst sys/linuxp
  (eq system-type 'gnu/linux)
  "Are we running on a GNU/Linux system?")

(defconst sys/macp
  (eq system-type 'darwin)
  "Are we running on a Mac system?")

(defconst sys/mac-x-p
  (and (display-graphic-p) sys/macp)
  "Are we running under X on a Mac system?")

(defconst sys/linux-x-p
  (and (display-graphic-p) sys/linuxp)
  "Are we running under X on a GNU/Linux system?")

(defconst sys/cygwinp
  (eq system-type 'cygwin)
  "Are we running on a Cygwin system?")

(defconst sys/rootp
  (string-equal "root" (getenv "USER"))
  "Are you using ROOT user?")


;; define custom variables

(defgroup my nil
  "Personal Emacs configurations."
  :group 'extensions)

(defcustom my-logo (expand-file-name "logo.png" user-emacs-directory)
  "Set Centaur logo. nil means official logo."
  :type 'string)

(defcustom my-full-name "Xing Wenju"
	"Set user full name."
	:type 'string)

(defcustom my-mail-address "xingwenju@gmail.com"
	"Set user email address."
	:type 'string)

(defcustom my-proxy "127.0.0.1:1087"
  "Set network proxy."
  :type 'string)

(defcustom my-package-archives 'melpa
  "Set package archives from which to fetch."
  :type '(choice
		  (const :tag "Melpa" melpa)
		  (const :tag "Emacs-China" emacs-china)
		  (const :tag "Tuna" tuna)))

(defcustom my-theme 'default
	"Set color theme."
	:type '(choice
			   (const :tag "Default theme" default)
			   (const :tag "Dark theme" dark)
			   (const :tag "Light theme" light)
			   (const :tag "Daylight theme" daylight)))

(defcustom my-cnfonts-enabled t
  "Enable cnfonts while startup or not."
  :type 'boolean)

(defcustom my-emoji-enabled nil
  "Enable emoji features or not."
  :type 'boolean)

(defcustom my-benchmark-enabled nil
	"Enable the init benchmark or not."
	:type 'boolean)

(defcustom my-dropbox-config-emacs-path "~/Dropbox/config/emacs"
	"Set config path."
	:type 'string)

(defcustom my-dropbox-shared-path "~/Dropbox/shared"
	"Set shared path."
	:type 'string)

(defcustom my-dropbox-blog-path "~/Dropbox/blog"
	"Set blog path."
	:type 'string)

(defcustom my-home-directory 'centaur
	"Set package archives from which to fetch."
	:type '(choice
			   (const :tag "Centaur" centaur)
			   (const :tag "Space" space)
			   (const :tag "Doom" doom)))

(defcustom my-custom-file-list 'centaur
	"Set package archives from which to fetch."
	:type '(choice
          (const :tag "windows-nt" "custom.win.el")
          (const :tag "darwin" "custom.mac.el")
          (const :tag "linux" "custom.linux.el")))
