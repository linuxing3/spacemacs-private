(defun x/refresh-packages ()
  (when (>= emacs-major-version 24)
    (require 'package)
    (setq package-archives '(
                             ("org"       . "http://orgmode.org/elpa/")
                             ("gnu"       . "http://elpa.gnu.org/packages/")
                             ("melpa"     . "http://melpa.org/packages/")
                             ("milkbox" . "http://melpa.milkbox.net/packages/")
                             ("elpy" . "http://jorgenschaefer.github.io/packages/")
                             ))
    (package-initialize)))

;; (x/refresh-packages)
