(defconst xingwenju-ui-packages
  '(
    ranger
    neotree
    ibuffer
    )
  )

(defun xingwenju-ui/post-init-ranger ()
  "Setting after using ranger"
  (progn
    (setq ranger-cleanup-on-disable t)
    (setq ranger-cleanup-eagerly t)
    (setq ranger-header-func 'ranger-header-line)
    (setq ranger-parent-header-func 'ranger-parent-header-line)
    (setq ranger-show-literal t)
    (setq ranger-width-preview 0.55)
    (setq ranger-ignored-extensions '("mkv" "iso" "mp4"))
    (setq ranger-max-preview-size 10)
  )
  )

(defun xingwenju-ui/post-init-neotree ()
  "Neotree is the nerdtree copy"
  (progn
    (use-package neotree :ensure nil)
    (setq neo-theme 'nerd)
    (setq neo-vc-integration 'face)
    )
  )

(defun xingwenju-ui/post-init-ibuffer ()
  ""
  (setq ibuffer-show-empty-filter-groups nil)
  )

(defun xingwenju-ui/pre-init-ibuffer ()
  (with-eval-after-load 'ibuffer
    (require 'projectile)
    (setq ibuffer-saved-filter-groups
          (list (cons "Default"
                      (append
                       (mapcar (lambda (it)
                                 (let ((name (file-name-nondirectory
                                              (directory-file-name it))))
                                   `(,name (filename . ,(expand-file-name it)))))
                               projectile-known-projects)
                       `(("Org" (mode . org-mode))
                         ("Dired" (mode . dired-mode))
                         ("IRC" (mode . erc-mode))
                         ("Python" (mode . python-mode))
                         ("Emacs" (or (name . "\\*Messages\\*")
                                      (name . "\\*Compile-Log\\*")
                                      (name . "\\*scratch\\*")
                                      (name . "\\*spacemacs\\*")
                                      (name . "\\*emacs\\*")))
                         ("Gtd" (or (name . "gtd.org")
                                      (name . "todo.org")
                                      (name . "daniel")
                                      (name . "wanglulu")))
                         ("Magit" (name . "\\*magit"))
                         ("Help" (name . "\\*Help\\*"))
                         ("Helm" (name . "\\*helm"))
                         )))))
    (add-hook 'buffer-mode-hook
              (defun bb-ibuffer/switch-ibuffer-group ()
                (ibuffer-switch-to-saved-filter-groups "Default")))
    (add-hook 'ibuffer-mode-hook 'ibuffer-auto-mode)))
