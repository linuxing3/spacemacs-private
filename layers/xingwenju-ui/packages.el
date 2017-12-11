(defconst xingwenju-ui-packages
  '(
    ranger
    neotree
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

(defun xingwenju-ui/init-neotree ()
  "Neotree is the nerdtree copy"
  (progn
    (use-package neotree :ensure t)
    (setq neo-theme 'nerd)
    (setq neo-vc-integration 'face)
    )
  )
