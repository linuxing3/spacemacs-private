(defun narrow-or-widen-dwim (p)
"If the buffer is narrowed, it widens. Otherwise, it narrows intelligently.
Intelligently means: region, org-src-block, org-subtree, or defun,
whichever applies first.
Narrowing to org-src-block actually calls `org-edit-src-code'.

With prefix P, don't widen, just narrow even if buffer is already
narrowed."
(interactive "P")
(declare (interactive-only))
(cond ((and (buffer-narrowed-p) (not p)) (widen))
((region-active-p)
(narrow-to-region (region-beginning) (region-end)))
((derived-mode-p 'org-mode)
;; `org-edit-src-code' is not a real narrowing command.
;; Remove this first conditional if you don't want it.
(cond ((ignore-errors (org-edit-src-code))
(delete-other-windows))
((org-at-block-p)
(org-narrow-to-block))
(t (org-narrow-to-subtree))))
(t (narrow-to-defun))))

;; (define-key endless/toggle-map "n" #'narrow-or-widen-dwim)
;; This line actually replaces Emacs' entire narrowing keymap, that's
;; how much I like this command. Only copy it if that's what you want.
(define-key ctl-x-map "n" #'narrow-or-widen-dwim)

(use-package web-mode
    :ensure t
    :config
     (add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
     (add-to-list 'auto-mode-alist '("\\.vue?\\'" . web-mode))
     (setq web-mode-engines-alist
       '(("django"    . "\\.html\\'")))
     (setq web-mode-ac-sources-alist
     '(("css" . (ac-source-css-property))
     ("vue" . (ac-source-words-in-buffer ac-source-abbrev))
     ("html" . (ac-source-words-in-buffer ac-source-abbrev))))
(setq web-mode-enable-auto-closing t))
(setq web-mode-enable-auto-quoting t) ; this fixes the quote problem I mentioned

(use-package emmet-mode
:ensure t
:config
(add-hook 'sgml-mode-hook 'emmet-mode) ;; Auto-start on any markup modes
(add-hook 'web-mode-hook 'emmet-mode) ;; Auto-start on any markup modes
(add-hook 'css-mode-hook  'emmet-mode) ;; enable Emmet's css abbreviation.
)

(use-package js2-mode
:ensure t
:ensure ac-js2
:init
(progn
(add-hook 'js-mode-hook 'js2-minor-mode)
(add-hook 'js2-mode-hook 'ac-js2-mode)
))

(use-package js2-refactor
:ensure t
:config
(progn
(js2r-add-keybindings-with-prefix "C-c C-m")
;; eg. extract function with `C-c C-m ef`.
(add-hook 'js2-mode-hook #'js2-refactor-mode)))
(use-package tern
:ensure tern
:ensure tern-auto-complete
:config
(progn
(add-hook 'js-mode-hook (lambda () (tern-mode t)))
(add-hook 'js2-mode-hook (lambda () (tern-mode t)))
(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))
(tern-ac-setup)
))

;;(use-package jade
;;:ensure t
;;)

(use-package nodejs-repl
:ensure t
)

(add-hook 'js-mode-hook
      (lambda ()
        (define-key js-mode-map (kbd "C-x C-e") 'nodejs-repl-send-last-sexp)
        (define-key js-mode-map (kbd "C-c C-r") 'nodejs-repl-send-region)
        (define-key js-mode-map (kbd "C-c C-l") 'nodejs-repl-load-file)
        (define-key js-mode-map (kbd "C-c C-z") 'nodejs-repl-switch-to-repl)))

(use-package dired+
  :ensure t
  :config (require 'dired+)
  )


(use-package dired-quick-sort
  :ensure t
  :config
  (dired-quick-sort-setup))

(setq user-full-name "Xing Wenju"
      user-mail-address "xingwenju@gmail.com")
;;--------------------------------------------------------------------------

;;--------------------------------------------------------------------------
;; latex
(use-package tex
:ensure auctex)

(defun tex-view ()
    (interactive)
    (tex-send-command "evince" (tex-append tex-print-file ".pdf")))


;;--------------------------------------------------------------------------

;; babel stuff

(org-babel-do-load-languages
 'org-babel-load-languages
 '((python . t)
   (emacs-lisp . t)
   (C . t)
   (js . t)
   (ditaa . t)
   (dot . t)
   (org . t)
   (shell . t )
   (latex . t )
   ))


;;--------------------------------------------------------------------------

;; projectile
(use-package projectile
  :ensure t
  :config
  (projectile-global-mode)
(setq projectile-completion-system 'ivy))

(use-package counsel-projectile
  :ensure t
  :config
  (counsel-projectile-on))

;;--------------------------------------------------------------------------
;; (use-package smartparens
;; :ensure t
;; :config
;; (use-package smartparens-config)
;; (use-package smartparens-html)
;; (use-package smartparens-python)
;; (use-package smartparens-latex)
;; (smartparens-global-mode t)
;; (show-smartparens-global-mode t))

;;--------------------------------------------


(use-package cider
  :ensure t
  :config
  ; this is to make cider-jack-in-cljs work
  (setq cider-cljs-lein-repl
      "(do (require 'figwheel-sidecar.repl-api)
       (figwheel-sidecar.repl-api/start-figwheel!)
       (figwheel-sidecar.repl-api/cljs-repl))")

  )

(use-package ac-cider
  :ensure t
  :config
  (add-hook 'cider-mode-hook 'ac-flyspell-workaround)
  (add-hook 'cider-mode-hook 'ac-cider-setup)
  (add-hook 'cider-repl-mode-hook 'ac-cider-setup)
  (eval-after-load "auto-complete"
    '(progn
       (add-to-list 'ac-modes 'cider-mode)
       (add-to-list 'ac-modes 'cider-repl-mode)))
  )

;;--------------------------------------------------------------------------
(use-package magit
:ensure t
:init
(progn
(bind-key "C-x g" 'magit-status)
))

(use-package git-gutter
:ensure t
:init
(global-git-gutter-mode +1))

(use-package git-timemachine
:ensure t
)

;; font scaling
(use-package default-text-scale
  :ensure t
  :config
  (global-set-key (kbd "C-M-=") 'default-text-scale-increase)
  (global-set-key (kbd "C-M--") 'default-text-scale-decrease))

(add-hook 'org-mode-hook 'turn-on-flyspell)
(add-hook 'org-mode-hook 'turn-on-auto-fill)
(add-hook 'mu4e-compose-mode-hook 'turn-on-flyspell)
(add-hook 'mu4e-compose-mode-hook 'turn-on-auto-fill)

(use-package youdao-dictionary
:ensure t)

(use-package shell-switcher
    :ensure t
    :config
    (setq shell-switcher-mode t)
    :bind (("C-'" . shell-switcher-switch-buffer)
       ("C-x 4 '" . shell-switcher-switch-buffer-other-window)
       ("C-M-'" . shell-switcher-new-shell)))


  ;; Visual commands
  (setq eshell-visual-commands '("vi" "screen" "top" "less" "more" "lynx"
                 "ncftp" "pine" "tin" "trn" "elm" "vim"
                 "nmtui" "alsamixer" "htop" "el" "elinks"
                 ))
  (setq eshell-visual-subcommands '(("git" "log" "diff" "show")))
  (setq eshell-list-files-after-cd t)
  (defun eshell-clear-buffer ()
    "Clear terminal"
    (interactive)
    (let ((inhibit-read-only t))
      (erase-buffer)
      (eshell-send-input)))
  (add-hook 'eshell-mode-hook
        '(lambda()
           (local-set-key (kbd "C-l") 'eshell-clear-buffer)))

  (defun eshell/magit ()
    "Function to open magit-status for the current directory"
    (interactive)
    (magit-status default-directory)
    nil)

 ;; smart display stuff
(require 'eshell)
(require 'em-smart)
(setq eshell-where-to-jump 'begin)
(setq eshell-review-quick-commands nil)
(setq eshell-smart-space-goes-to-end t)

(add-hook 'eshell-mode-hook
  (lambda ()
    (eshell-smart-initialize)))
;; eshell here
(defun eshell-here ()
  "Opens up a new shell in the directory associated with the
current buffer's file. The eshell is renamed to match that
directory to make multiple eshell windows easier."
  (interactive)
  (let* ((parent (if (buffer-file-name)
             (file-name-directory (buffer-file-name))
           default-directory))
     (height (/ (window-total-height) 3))
     (name   (car (last (split-string parent "/" t)))))
    (split-window-vertically (- height))
    (other-window 1)
    (eshell "new")
    (rename-buffer (concat "*eshell: " name "*"))

    (insert (concat "ls"))
    (eshell-send-input)))

(global-set-key (kbd "C-!") 'eshell-here)

(defcustom dotemacs-eshell/prompt-git-info
  t
  "Turns on additional git information in the prompt."
  :group 'dotemacs-eshell
  :type 'boolean)

;; (epe-colorize-with-face "abc" 'font-lock-comment-face)
(defmacro epe-colorize-with-face (str face)
  `(propertize ,str 'face ,face))

(defface epe-venv-face
  '((t (:inherit font-lock-comment-face)))
  "Face of python virtual environment info in prompt."
  :group 'epe)

  (setq eshell-prompt-function
      (lambda ()
    (concat (propertize (abbreviate-file-name (eshell/pwd)) 'face 'eshell-prompt)
        (when (and dotemacs-eshell/prompt-git-info
               (fboundp #'vc-git-branches))
          (let ((branch (car (vc-git-branches))))
            (when branch
              (concat
               (propertize " [" 'face 'font-lock-keyword-face)
               (propertize branch 'face 'font-lock-function-name-face)
               (let* ((status (shell-command-to-string "git status --porcelain"))
                  (parts (split-string status "\n" t " "))
                  (states (mapcar #'string-to-char parts))
                  (added (count-if (lambda (char) (= char ?A)) states))
                  (modified (count-if (lambda (char) (= char ?M)) states))
                  (deleted (count-if (lambda (char) (= char ?D)) states)))
             (when (> (+ added modified deleted) 0)
               (propertize (format " +%d ~%d -%d" added modified deleted) 'face 'font-lock-comment-face)))
               (propertize "]" 'face 'font-lock-keyword-face)))))
        (when (and (boundp #'venv-current-name) venv-current-name)
          (concat
            (epe-colorize-with-face " [" 'epe-venv-face)
            (propertize venv-current-name 'face `(:foreground "#2E8B57" :slant italic))
            (epe-colorize-with-face "]" 'epe-venv-face)))
        (propertize " $ " 'face 'font-lock-constant-face))))

(use-package elfeed
  :ensure t
  :config
  (setq elfeed-db-directory "~/Dropbox/shared/elfeeddb")
  (setq elfeed-feeds
  '("http://nullprogram.com/feed/"
    "http://jr0cket.co.uk/atom.xml"
    "https://linuxing3.github.io/rss.xml"
    "http://ergoemacs.org/emacs/blog.xml"
    "http://planet.emacsen.org/atom.xml"))
  )


;; wget https://github.com/remyhonig/elfeed-org/blob/master/elfeed-org.el
(use-package elfeed-org
  :ensure t
  :config
 (setq rmh-elfeed-org-files (list
   "~/Dropbox/config/emacs/literate/xingwenju-elfeed-resource.org"
  )))

(use-package ggtags
:ensure t
:config
(add-hook 'c-mode-common-hook
      (lambda ()
        (when (derived-mode-p 'c-mode 'c++-mode 'java-mode)
          (ggtags-mode 1))))
)

(use-package dumb-jump
  :bind (("M-g o" . dumb-jump-go-other-window)
     ("M-g j" . dumb-jump-go)
     ("M-g x" . dumb-jump-go-prefer-external)
     ("M-g z" . dumb-jump-go-prefer-external-other-window))
  :config
  ;; (setq dumb-jump-selector 'ivy) ;; (setq dumb-jump-selector 'helm)
:init
(dumb-jump-mode)
  :ensure
)

(use-package origami
:ensure t)

(global-set-key (kbd "C-x C-b") 'ibuffer)
(setq ibuffer-saved-filter-groups
  (quote (("default"
       ("dired" (mode . dired-mode))
       ("org" (name . "^.*org$"))

       ("web" (or (mode . web-mode) (mode . js2-mode)))
       ("shell" (or (mode . eshell-mode) (mode . shell-mode)))
       ("mu4e" (or

       (mode . mu4e-compose-mode)
       (name . "\*mu4e\*")
       ))
       ("programming" (or
               (mode . python-mode)
               (mode . c++-mode)))
       ("emacs" (or
             (name . "^\\*scratch\\*$")
             (name . "^\\*Messages\\*$")))
       ))))
(add-hook 'ibuffer-mode-hook
      (lambda ()
        (ibuffer-auto-mode 1)
        (ibuffer-switch-to-saved-filter-groups "default")))

;; don't show these
                    ;(add-to-list 'ibuffer-never-show-predicates "zowie")
;; Don't show filter groups if there are no buffers in that group
(setq ibuffer-show-empty-filter-groups nil)

;; Don't ask for confirmation to delete marked buffers
(setq ibuffer-expert t)

(use-package prodigy
  :ensure t
  :config)

(prodigy-define-service
  :name "Python app"
  :command "/usr/bin/python"
  :args '("-m" "SimpleHTTPServer" "6001")
  :cwd "/Dropbox/Dropbox/xingwenju.com/blogs/output"
  :tags '(work)
  :stop-signal 'sigkill
  :kill-process-buffer-on-stop t)

(prodigy-define-service
  :name "Nikola Blog Local Serve"
  :command "/usr/local/anaconda3/bin/nikola"
  :args '("serve" "-p" "9999")
  :cwd "/Dropbox/Dropbox/xingwenju.com/blogs"
  :tags '(work)
  :stop-signal 'sigkill
  :kill-process-buffer-on-stop t)

(prodigy-define-service
  :name "Nikola Blog Build"
  :command "/usr/local/anaconda3/bin/nikola"
  :args '("build")
  :cwd "/Dropbox/Dropbox/xingwenju.com/blogs"
  :tags '(work)
  :stop-signal 'sigkill
  :kill-process-buffer-on-stop t)

(prodigy-define-service
  :name "Nikola Blog Deploy Github"
  :command "/usr/local/anaconda3/bin/nikola"
  :args '("github_deploy")
  :cwd "/Dropbox/Dropbox/xingwenju.com/blogs"
  :tags '(work)
  :stop-signal 'sigkill
  :kill-process-buffer-on-stop t)

(use-package treemacs
  :ensure t
  :defer t
  :config
  (progn

  (setq treemacs-follow-after-init          t
    treemacs-width                      35
    treemacs-indentation                2
    treemacs-git-integration            t
    treemacs-collapse-dirs              3
    treemacs-silent-refresh             nil
    treemacs-change-root-without-asking nil
    treemacs-sorting                    'alphabetic-desc
    treemacs-show-hidden-files          t
    treemacs-never-persist              nil
    treemacs-is-never-other-window      nil
    treemacs-goto-tag-strategy          'refetch-index)

  (treemacs-follow-mode t)
  (treemacs-filewatch-mode t)
  ))

(use-package treemacs-projectile
:defer t
:ensure t
:config
(setq treemacs-header-function #'treemacs-projectile-create-header))

(defun load-if-exists (f)
  "load the elisp file only if it exists and is readable"
  (if (file-readable-p f)
  (load-file f)))

(defun babel-load-if-exists (f)
  "babel load the elisp file only if it exists and is readable"
  (if (file-readable-p f)
  (org-babel-load-file f)))

(defun xingwenju/reload-init ()
  "Reload the init file"
  (interactive)
  (load-file "~/Dropbox/config/emacs/common/init.el")
  )

(defun xingwenju/set-bookmark-file ()
  "Load the bookmark file"
  (interactive)
  (setq bookmark-file "~/Dropbox/shared/emacs-bookmarks")
  (bookmark-load bookmark-file)
  )
(defun set-w3m-command ()
  "Set the w3m-command for different OS"
  (if (string-equal system-type "darwin")
    (setq w3m-command "/usr/local/Cellar/w3m/0.5.3/bin/w3m"))
  (if (string-equal system-type "gnu/linux")
    (setq w3m-command "/usr/local/bin/w3m"))
  (if (string-equal system-type "windows-nt")
    (setq w3m-command "c:\var\w3m\bin\w3m"))
)
