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
        javascript
        ;; company ;; add auto-completion in a layer
        ;; (company-anaconda :toggle (configuration-layer/package-usedp 'company))
        exec-path-from-shell
        ))

(defun xingwenju-programming/post-init-javascript ()
  "Setting js-mode"
  (progn
    (setq-default js2-basic-offset 2)
    (setq-default js-indent-level 2)
    (setq tags-table-list (list "~/workspace/cp-work-puppeteer/src/TAGS"))
    (add-hook js2-mode-hook x/js2-mode-hook)))

(defun xingwenju-programming/post-init-python ()
  "Python is a easy and quick language"
  (progn
    (setq python-indent-offset 4)
    (setq python-enable-yapf-format-on-save t)
    ;; Add elpy
    (add-to-list 'package-archives
                 '("elpy" . "http://jorgenschaefer.github.io/packages/")))
    ;;(package-refresh-contents)
  ;; ends here
  )

;; Hook company to python-mode
;; (defun xingwenju-programming/post-init-company ()
;;   (spacemacs|add-company-hook python-mode))

;; Add the backend to the major-mode specific backend list
;; (defun xingwenju-programming/init-company-anaconda ()
;;   (use-package company-anaconda
;;     :defer t
;;     :init (push 'company-anaconda company-backends-python-mode)))

(defun xingwenju-programming/post-init-exec-path-from-shell ()
  "exec path fro env"
  ;; Add GOPATH to shell
  (use-package exec-path-from-shell
    :config
    (when (memq window-system '(mac ns))
      (exec-path-from-shell-copy-env "GOPATH")
      (exec-path-from-shell-copy-env "PYTHONPATH")
      (exec-path-from-shell-initialize))))
