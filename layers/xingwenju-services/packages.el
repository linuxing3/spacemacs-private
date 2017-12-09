;;; packages.el --- xingwenju-services layer packages file for Spacemacs.
;;
;; Copyright (c) 2012-2017 Sylvain Benner & Contributors
;;
;; Author:  <ShiYongRen@03-1302940>
;; URL: https://github.com/syl20bnr/spacemacs
;;
;; This file is not part of GNU Emacs.
;;
;;; License: GPLv3

;;; Commentary:

;; See the Spacemacs documentation and FAQs for instructions on how to implement
;; a new layer:
;;
;;   SPC h SPC layers RET
;;
;;
;; Briefly, each package to be installed or configured by this layer should be
;; added to `xingwenju-services-packages'. Then, for each package PACKAGE:
;;
;; - If PACKAGE is not referenced by any other Spacemacs layer, define a
;;   function `xingwenju-services/init-PACKAGE' to load and initialize the package.

;; - Otherwise, PACKAGE is already referenced by another Spacemacs layer, so
;;   define the functions `xingwenju-services/pre-init-PACKAGE' and/or
;;   `xingwenju-services/post-init-PACKAGE' to customize the package as it is loaded.

;;; Code:

(defconst xingwenju-services-packages
  '(
    evil ;; vim
    prodigy ;; services
    hydra ;; keys
    ))

(defun xingwenju-services/post-init-prodigy ()
  "Prodigy is the service manager"
    (progn
        (prodigy-define-service
          :name "Nikola Blog Local Serve"
          :command "nikola"
          :args '("serve" "-p" "9999")
          :cwd "~/Dropbox/xingwenju.com/blogs"
          :tags '(work)
          :stop-signal 'sigkill
          :kill-process-buffer-on-stop t)

        (prodigy-define-service
          :name "Nikola Blog Build"
          :command "nikola"
          :args '("build")
          :cwd "~/Dropbox/xingwenju.com/blogs"
          :tags '(work)
          :stop-signal 'sigkill
          :kill-process-buffer-on-stop t)

        (prodigy-define-service
          :name "Nikola Blog Deploy Github"
          :command "nikola"
          :args '("github_deploy")
          :cwd "~/Dropbox/xingwenju.com/blogs"
          :tags '(work)
          :stop-signal 'sigkill
          :kill-process-buffer-on-stop t)

        (prodigy-define-service
          :name "Run Dev Server of cp-vuetify"
          :command "node"
          :args '(".electron-vue/dev-runner.js")
          :cwd "~/workspace/cp-vuetify"
          :tags '(work)
          :stop-signal 'sigkill
          :kill-process-buffer-on-stop t)
    )
   )

(defun xingwenju-services/post-init-hydra ()
  (progn
    (defhydra hydra-hotspots (:color blue)
      "Hotspots"
      ("b" blog-admin-start "blog")
      ("g" helm-github-stars "helm github stars")
      ("r" x/run-current-file "run current file"))

    (defhydra multiple-cursors-hydra (:hint nil)
      "
       ^Up^            ^Down^        ^Other^
             ----------------------------------------------
         [_p_]   Next    [_n_]   Next    [_l_] Edit lines
         [_P_]   Skip    [_N_]   Skip    [_a_] Mark all
         [_M-p_] Unmark  [_M-n_] Unmark [_r_] Mark by regexp
         ^ ^             ^ ^ [_q_] Quit
       "
      ("l" mc/edit-lines :exit t)
      ("a" mc/mark-all-like-this :exit t)
      ("n" mc/mark-next-like-this)
      ("N" mc/skip-to-next-like-this)
      ("M-n" mc/unmark-next-like-this)
      ("p" mc/mark-previous-like-this)
      ("P" mc/skip-to-previous-like-this)
      ("M-p" mc/unmark-previous-like-this)
      ("r" mc/mark-all-in-region-regexp :exit t)
      ("q"
       nil))

    (defhydra
      hydra-apropos (:color blue)
      "Apropos"
      ("a" apropos "apropos")
      ("c" apropos-command "cmd")
      ("d" apropos-documentation "doc")
      ("e" apropos-value "val")
      ("l" apropos-library "lib")
      ("o" apropos-user-option "option")
      ("u" apropos-user-option "option")
      ("v" apropos-variable "var")
      ("i" info-apropos "info")
      ("t" tags-apropos "tags")
      ("z" hydra-customize-apropos/body "customize"))

    (defhydra
      hydra-customize-apropos (:color blue)
      "Apropos (customize)"
      ("a" customize-apropos "apropos")
      ("f" customize-apropos-faces "faces")
      ("g" customize-apropos-groups "groups")
      ("o" customize-apropos-options "options"))

    (define-key global-map (kbd "<f1>") 'hydra-hotspots/body)
    (spacemacs/set-leader-keys "oo" 'hydra-hotspots/body)
    ;; (bind-key*  "<f4>" 'hydra-apropos/body)
    (spacemacs/set-leader-keys "oh" 'hydra-apropos/body)

    ))

(defun xingwenju-services/post-init-evil ()
  (progn
    (setcdr evil-insert-state-map nil)

    (define-key evil-insert-state-map [escape] 'evil-normal-state)

    ;; Open ibuffer
    (spacemacs/set-leader-keys "bi" 'ibuffer)

    ;; disable highlight when use swiper or evil ex search, this option won't effect evil-ex-search-next command
    (setq-default evil-ex-search-persistent-highlight nil)

    (push "TAGS" spacemacs-useless-buffers-regexp)

    (adjust-major-mode-keymap-with-evil "git-timemachine")
    (adjust-major-mode-keymap-with-evil "tabulated-list")

    (define-key evil-visual-state-map "p" 'evil-paste-after-from-0)
    (define-key evil-insert-state-map (kbd "C-r") 'evil-paste-from-register)

    ;; ;; change evil initial mode state
    (loop for (mode . state) in
          '((shell-mode . normal))
          do (evil-set-initial-state mode state))

    ;;mimic "nzz" in vim
    (defadvice evil-search-next (after advice-for-evil-search-next activate)
      (evil-scroll-line-to-center (line-number-at-pos)))

    (defadvice evil-search-previous (after advice-for-evil-search-previous activate)
      (evil-scroll-line-to-center (line-number-at-pos)))

    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ;; Comment current line
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    (define-key evil-normal-state-map (kbd ",/") 'evilnc-comment-or-uncomment-lines)

    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ;; My yank file
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    (defun my-evil-yank ()
      (interactive)
      (save-excursion
        (call-interactively 'evil-yank))
      (backward-char))

    (define-key evil-visual-state-map (kbd "y") 'my-evil-yank)

    (define-key evil-normal-state-map
      (kbd "Y") 'x/yank-to-end-of-line)

    ;; rebind g,k to gj and gk
    ;; (define-key evil-normal-state-map (kbd "j") 'evil-next-visual-line)
    ;; (define-key evil-normal-state-map (kbd "k") 'evil-previous-visual-line)
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ;; Normal states
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    (define-key evil-normal-state-map (kbd "[ SPC") (lambda () (interactive) (evil-insert-newline-above) (forward-line)))
    (define-key evil-normal-state-map (kbd "] SPC") (lambda () (interactive) (evil-insert-newline-below) (forward-line -1)))
    (define-key evil-normal-state-map (kbd "[ b") 'previous-buffer)
    (define-key evil-normal-state-map (kbd "] b") 'next-buffer)
    (define-key evil-normal-state-map (kbd "M-y") 'counsel-yank-pop)

    ;; (define-key evil-insert-state-map "\C-e" 'end-of-line)
    ;; (define-key evil-insert-state-map "\C-n" 'next-line)
    ;; (define-key evil-insert-state-map "\C-k" 'kill-line)
    (define-key evil-emacs-state-map (kbd "s-f") 'forward-word)
    (define-key evil-insert-state-map (kbd "s-f") 'forward-word)
    (define-key evil-emacs-state-map (kbd "s-b") 'backward-word)
    (define-key evil-insert-state-map (kbd "s-b") 'backward-word)


    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ;; Ex states
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    (define-key evil-ex-completion-map "\C-a" 'move-beginning-of-line)
    (define-key evil-ex-completion-map "\C-b" 'backward-char)
    (define-key evil-ex-completion-map "\C-k" 'kill-line)
    (define-key minibuffer-local-map (kbd "C-w") 'evil-delete-backward-word)

    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ;; Visual states
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    (define-key evil-visual-state-map (kbd ",/") 'evilnc-comment-or-uncomment-lines)
    ;; (define-key evil-visual-state-map (kbd "x") 'er/expand-region)
    ;; (define-key evil-visual-state-map (kbd "X") 'er/contract-region)
    (define-key evil-visual-state-map (kbd "C-r") 'x/evil-quick-replace)
    (define-key evil-visual-state-map (kbd "mn") 'mc/mark-next-like-this)
    (define-key evil-visual-state-map (kbd "mp") 'mc/mark-previous-like-this)
    (define-key evil-visual-state-map (kbd "ma") 'mc/mark-all-like-this)
    (define-key evil-visual-state-map (kbd "mf") 'mc/mark-all-like-this-in-defun)


    ;; in spacemacs, we always use evilify miscro state
    (evil-add-hjkl-bindings package-menu-mode-map 'emacs)
    ;; Don't move back the cursor one position when exiting insert mode
    (setq evil-move-cursor-back nil)

    ;; (define-key evil-emacs-state-map (kbd "C-w h") 'evil-window-left)
    (define-key evil-emacs-state-map (kbd "C-w") 'evil-delete-backward-word)
    ;; (define-key evil-emacs-state-map (kbd "C-w j") 'evil-window-down)
    ;; (define-key evil-emacs-state-map (kbd "C-w k") 'evil-window-up)
    ;; (define-key evil-emacs-state-map (kbd "C-w l") 'evil-window-right)

    ;; for emacs shell mode
    ;; (define-key evil-emacs-state-map (kbd "s-b") 'ido-switch-buffer)
    ;; (define-key evil-emacs-state-map (kbd "s-f") 'ido-find-file)
    (evil-define-key 'emacs term-raw-map (kbd "C-w")
      'evil-delete-backward-word)


    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ;; Normal state tag
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    (setq evil-normal-state-tag   (propertize "[N]" 'face '((:background "DarkGoldenrod2" :foreground "black")))
          evil-emacs-state-tag    (propertize "[E]" 'face '((:background "SkyBlue2" :foreground "black")))
          evil-insert-state-tag   (propertize "[I]" 'face '((:background "chartreuse3") :foreground "white"))
          evil-motion-state-tag   (propertize "[M]" 'face '((:background "plum3") :foreground "white"))
          evil-visual-state-tag   (propertize "[V]" 'face '((:background "gray" :foreground "black")))
          evil-operator-state-tag (propertize "[O]" 'face '((:background "purple"))))
    (setq evil-insert-state-cursor '("chartreuse3" box))
    (define-key evil-insert-state-map (kbd "C-z") 'evil-emacs-state)
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ;; End
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ))
;;; packages.el ends here
