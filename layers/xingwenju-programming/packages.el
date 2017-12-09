;;; packages.el --- xingwenju Layer packages File for Spacemacs
;;
;; Copyright (c) 2014-2016 xingwenju
;;
;; Author: xingwenju <xingwenju@gmail.com>
;; URL: https://github.com/xingwenju/spacemacs-private
;;
;; This file is not part of GNU Emacs.
;;
;;; License: GPLv3

;; List of all packages to install and/or initialize. Built-in packages
;; which require an initialization must be listed explicitly in the list.

(setq xingwenju-programming-packages
      '(
        ;; nodejs-repl
        python
        exec-path-from-shell
        ))


(defun xingwenju-programming/post-init-python ()
  "Python is a easy and quick language"
  (progn
    ;; Add elpy
    (add-to-list 'package-archives
                 '("elpy" . "http://jorgenschaefer.github.io/packages/"))
    )
    (package-refresh-contents)
    (package-refresh-contents)
  ;; ends here

  )


(defun xingwenju-programming/post-init-exec-path-from-shell ()
  "exec path fro env"
  ;; Add GOPATH to shell
  (use-package exec-path-from-shell
    :config
    (when (memq window-system '(mac ns))
      (exec-path-from-shell-copy-env "GOPATH")
      (exec-path-from-shell-copy-env "PYTHONPATH")
      (exec-path-from-shell-initialize)))
  )
