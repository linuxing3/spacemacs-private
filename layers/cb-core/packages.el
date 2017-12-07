;;; packages.el --- cb-core Layer packages File for Spacemacs
;;; Commentary:
;;; Code:

(eval-when-compile
  (require 'cb-vars nil t)
  (require 'use-package)
  (require 'cb-use-package-extensions))

(require 's)
(require 'dash)
(require 'f)
(require 'noflet)

(defconst cb-core-packages
  '(dash-functional
    diminish
    auto-revert
    hideshow
    helm
    aggressive-indent
    ag
    wgrep-ag
    alert
    helm-gtags
    world-time-mode
    iedit
    hl-line
    eldoc
    ido
    recentf
    neotree
    time
    persp-mode
    (compile :location built-in)
    (tramp :location built-in)

    (cb-buffers :location local)
    (cb-subr-x :location local)
    (locate-key-binding :location local)
    (smart-ops :location local)
    (case :location local)
    (create-layer-local-package :location local)
    (indirect-region :location local)
    (remove-line-breaks :location local)
    (insert-timestamp :location local)
    (insert-shebang :location local)
    (insert-variable-value :location local)
    (helm-http-status :location local)
    (indent-dwim :location local)
    (replace-smart-quotes :location local)
    (cb-transpose-line :location local)
    (cb-core-rename-file-and-buffer :location local)
    (cb-rotate-window-split :location local)
    (cb-exit-emacs :location local)
    (cb-generate-password :location local)
    (cb-font-lock-replace-match :location local)
    (cb-remap-face :location local)
    (cb-ligatures :location local)
    (cb-helm-emoticons :location local)))

(defun cb-core/user-config ()
  "This procedure should be called in `dotspacemacs/user-config'."
  (setq recentf-max-saved-items 1000)
  (setq bookmark-save-flag nil))

(defun cb-core/init-dash-functional ()
  (use-package dash-functional
    :config (require 'dash-functional)))

(defun cb-core/init-cb-subr-x ()
  (use-package cb-subr-x))

(defun cb-core/post-init-diminish ()
  (diminish 'auto-fill-function " ≣"))

(defun cb-core/post-init-autorevert ()
  (diminish 'auto-revert-mode))

(defun cb-core/post-init-hideshow ()
  (diminish 'hs-minor-mode))

(defun cb-core/post-init-helm ()
  (use-package helm
    :bind
    (:map
     helm-map
     ("<tab>" . helm-execute-persistent-action)
     ("C-i" . helm-execute-persistent-action)
     ("C-z" . helm-select-action)
     ("C-SPC" . helm-toggle-visible-mark))
    :bind*
    (("S-SPC" . helm-M-x)
     ("M-x" . helm-M-x)
     ("s-b" . helm-buffers-list))
    :leader-bind
    (("oo" . helm-occur)
     ("RET" . helm-imenu))
    :config
    (progn
      (helm-autoresize-mode +1)
      (setq helm-mode-fuzzy-match t)

      (setq helm-locate-command
            (pcase system-type
              (`gnu/linux "locate -i -r %s")
              (`berkeley-unix "locate -i %s")
              (`windows-nt "es %s")
              (`darwin "mdfind -name %s %s | egrep -v '/Library/(Caches|Mail)/'")
              (t "locate %s")))

      (custom-set-faces
       `(helm-locate-finish
         ((t (:foreground ,cb-vars-solarized-hl-cyan))))
       '(helm-selection
         ((((background light)) :background "gray90" :foreground "black" :underline nil)
          (((background dark))  :background "black"  :foreground "white" :underline nil))))))

  (defun cb-core/post-init-aggressive-indent ()
    (use-package aggressive-indent
      :config
      (progn
        (add-to-list 'aggressive-indent-excluded-modes 'restclient-mode)
        (global-aggressive-indent-mode)))))

(defun cb-core/post-init-persp-mode ()
  (use-package persp-mode
    :defer t
    :config
    (bind-key "C-SPC" #'spacemacs/persp-helm-mini)
    (bind-key "C-@" #'spacemacs/persp-helm-mini)))

(defun cb-core/init-ag ()
  (use-package ag :commands ag))

(defun cb-core/init-wgrep-ag ()
  (use-package wgrep-ag
    :defer t))

(defun cb-core/init-alert ()
  (use-package alert
    :defer t
    :config
    (progn
      ;; HACK: Fix broken OSX implementation.
      (defun alert-osx-notifier-notify (info)
        (call-process "osascript" nil nil nil
                      "-e"
                      (format "display notification %S with title %S"
                              (alert-encode-string (plist-get info :message))
                              (alert-encode-string (plist-get info :title))))
        (alert-message-notify info))

      (if (eq system-type 'darwin)
          (setq alert-default-style 'osx-notifier)
        (setq alert-default-style 'libnotify)))))

(defun cb-core/post-init-helm-gtags ()
  (use-package helm-gtags
    :bind
    (:map
     helm-gtags-mode-map
     ("M-." . helm-gtags-dwim)
     ("M-," . helm-gtags-pop-stack))
    :evil-bind
    (:map
     helm-gtags-mode-map
     :state normal
     ("M-." . helm-gtags-dwim)
     ("M-," . helm-gtags-pop-stack)
     :state insert
     ("M-." . helm-gtags-dwim)
     ("M-," . helm-gtags-pop-stack))
    :config
    (progn
      (setq helm-gtags-ignore-case t)
      (setq helm-gtags-auto-update t)
      (setq helm-gtags-use-input-at-cursor t)
      (setq helm-gtags-pulse-at-cursor t)
      (setq helm-gtags-prefix-key "\C-cg")
      (setq helm-gtags-suggested-key-mapping t)))

  (with-eval-after-load 'pulse
    (cb-remap-face 'pulse-highlight-face 'cb-faces-bg-flash)
    (cb-remap-face 'pulse-highlight-start-face 'cb-faces-bg-flash)))

(defun cb-core/init-world-time-mode ()
  (use-package world-time-mode
    :evil-bind
    (:map world-time-table-mode-map :state normal ("q" . quit-window))
    :leader-bind (("at" . world-time-list))
    :config
    (progn
      (setq display-time-world-list '(("Pacific/Auckland" "NZT")
                                      ("UTC" "UTC")
                                      ("Europe/Berlin" "Germany")
                                      ("America/Los_Angeles" "Los Angeles")
                                      ("America/New_York" "New York")
                                      ("America/Denver" "Mountain Time")
                                      ("Australia/Sydney" "Sydney")))

      (add-hook 'world-time-table-mode-hook 'hl-line-mode))))

(defun cb-core/init-smart-ops ()
  (use-package smart-ops
    :diminish smart-ops-mode
    :functions (smart-ops-init)
    :config (smart-ops-init)))

(defun cb-core/post-init-iedit ()
  (use-package iedit
    :config
    (custom-set-faces
     `(iedit-occurrence ((t (:background ,cb-vars-solarized-hl-orange :foreground "white")))))))

(defun cb-core/post-init-hl-line ()
  (global-hl-line-mode -1))

(defun cb-core/post-init-eldoc ()
  (setq eldoc-idle-delay 0.1))

(defun cb-core/init-case ()
  (use-package case))

(defun cb-core/init-locate-key-binding ()
  (use-package locate-key-binding
    :commands (locate-key-binding)))

(defun cb-core/post-init-recentf ()
  (use-package recentf
    :config
    (progn
      (setq recentf-save-file (concat spacemacs-cache-directory "recentf"))
      (setq recentf-max-menu-items 10)
      (setq recentf-keep '(file-remote-p file-readable-p))

      (defun cb-core/shut-up-recentf (old-fn &rest rs)
        (noflet ((message (&rest args)))
          (apply old-fn rs)))

      (advice-add 'recentf-cleanup :around #'cb-core/shut-up-recentf)

      (setq recentf-exclude
            (-distinct (-concat recentf-exclude
                                (--map (format "/%s/" (regexp-quote it)) cb-vars-ignored-dirs)
                                cb-vars-ignored-files-regexps)))
      (recentf-cleanup))))

(defun cb-core/post-init-ido ()
  (use-package ido
    :config
    (progn
      (setq ido-use-filename-at-point 'guess)

      (add-to-list 'ido-ignore-buffers "\\*helm.*")
      (add-to-list 'ido-ignore-buffers "\\*Minibuf.*")

      (dolist (regexp cb-vars-ignored-files-regexps)
        (add-to-list 'ido-ignore-files regexp))

      (defun cb-core/ido-find-file-as-root (&rest _)
        (spacemacs/sudo-edit))

      (advice-add #'ido-find-file :after #'cb-core/ido-find-file-as-root))))

(defun cb-core/init-cb-buffers ()
  (use-package cb-buffers
    :bind
    (("C-c k b" . cb-buffers-maybe-kill-all))
    :bind*
    (("C-<backspace>" . cb-buffers-maybe-kill))))

(defun cb-core/post-init-neotree ()
  (use-package neotree
    :config
    (progn
      (setq neo-theme 'arrow)

      ;; HACK: prevent neotree from moving cursor after hitting <RET>.

      (defun cb-core--restoring-pos (f &rest args)
        (let ((p (point)))
          (apply f args)
          (goto-char p)))

      (advice-add #'neotree-enter :around #'cb-core--restoring-pos))))

(defun cb-core/init-create-layer-local-package ()
  (use-package create-layer-local-package
    :commands (create-layer-local-package)))

(defun cb-core/init-indirect-region ()
  (use-package indirect-region
    :commands (indirect-region)))

(defun cb-core/init-remove-line-breaks ()
  (use-package remove-line-breaks
    :commands (remove-line-breaks)))

(defun cb-core/init-insert-timestamp ()
  (use-package insert-timestamp
    :commands (insert-timestamp)
    :init (spacemacs/set-leader-keys "iT" #'insert-timestamp)))

(defun cb-core/init-insert-shebang ()
  (use-package insert-shebang
    :commands (insert-shebang)
    :init (spacemacs/set-leader-keys "i#" 'insert-shebang)))

(defun cb-core/init-insert-variable-value ()
  (use-package insert-variable-value
    :commands (insert-variable-value)))

(defun cb-core/init-helm-http-status ()
  (use-package helm-http-status
    :commands (helm-http-status)))

(defun cb-core/init-indent-dwim ()
  (use-package indent-dwim
    :functions (indent-dwim-init)
    :config (indent-dwim-init)))

(defun cb-core/init-time ()
  (use-package time
    :config
    (progn
      (setq display-time-default-load-average nil)
      (display-time-mode +1))))

(defun cb-core/init-compile ()
  (use-package compile
    :defer t
    :config
    (progn
      (defun cb-core-ansi-colourise-compilation ()
        (ansi-color-apply-on-region compilation-filter-start (point)))
      (add-hook 'compilation-filter-hook #'cb-core-ansi-colourise-compilation))))

(defun cb-core/init-replace-smart-quotes ()
  (use-package replace-smart-quotes
    :commands (replace-smart-quotes-region
               replace-smart-quotes-buffer)))

(defun cb-core/init-cb-transpose-line ()
  (use-package cb-transpose-line
    :evil-bind
    (:state normal
            ("C-<up>" . cb-transpose-line-up)
            ("C-<down>" . cb-transpose-line-down))))

(defun cb-core/init-cb-core-rename-file-and-buffer ()
  (use-package cb-core-rename-file-and-buffer
    :config
    (progn
      (defalias 'rfb #'cb-core-rename-file-and-buffer)
      (defalias 'rbf #'cb-core-rename-file-and-buffer)
      (defalias 'mv  #'cb-core-rename-file-and-buffer-mv))))

(defun cb-core/init-cb-rotate-window-split ()
  (use-package cb-rotate-window-split
    :evil-bind
    (:state normal ("C-w |" . cb-rotate-window-split))
    :leader-bind (("|" . cb-rotate-window-split))))

(defun cb-core/init-cb-exit-emacs ()
  (use-package cb-exit-emacs
    :bind
    (("C-c k k" . cb-exit-emacs)
     ("C-x C-c" . cb-exit-emacs-warn-rebound))))

(defun cb-core/init-cb-generate-password ()
  (use-package cb-generate-password
    :commands cb-generate-password))

(defun cb-core/init-cb-font-lock-replace-match ()
  (use-package cb-font-lock-replace-match))

(defun cb-core/init-cb-remap-face ()
  (use-package cb-remap-face
    :functions (cb-remap-face cb-remap-face-restore)
    :config
    (progn
      (advice-add #'spacemacs//ido-navigation-ms-on-exit :after #'cb-remap-face-restore)
      (advice-add #'spacemacs//ido-setup :after #'cb-remap-face-restore)
      (advice-add #'spacemacs//helm-before-initialize :after #'cb-remap-face-restore))))

(defun cb-core/init-cb-ligatures ()
  (use-package cb-ligatures
    :config
    (progn
      (cb-ligatures-init)
      (global-prettify-symbols-mode +1)
      (add-hook 'text-mode-hook #'prettify-symbols-mode)
      (add-hook 'prog-mode-hook #'prettify-symbols-mode))))

(defun cb-core/init-tramp ()
  (use-package tramp
    :defer t
    :config
    (setq vc-ignore-dir-regexp (format "\\(%s\\)\\|\\(%s\\)" vc-ignore-dir-regexp tramp-file-name-regexp))))

(defun cb-core/init-cb-helm-emoticons ()
  (use-package cb-helm-emoticons
    :commands cb-helm-emoticons))

;;; packages.el ends here
