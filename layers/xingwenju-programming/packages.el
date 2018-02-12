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
        pyvenv
        js2-mode
        ;; company ;; add auto-completion in a layer
        ;; (company-anaconda :toggle (configuration-layer/package-usedp 'company))
        exec-path-from-shell
        ))

(defun xingwenju-programming/post-init-js2-mode ()
  "Setting js-mode"
  (progn
    (add-hook 'js2-mode-hook 'x/js2-mode-hook)
    (setq company-backends-js2-mode '(
                                      (company-dabbrev-code :with company-keywords company-etags)
                                      company-files company-dabbrev))
    (with-eval-after-load 'js2-mode
     (progn
        (setq-default js2-allow-rhino-new-expr-initializer nil)
        (setq-default js2-auto-indent-p nil)
        (setq-default js2-enter-indents-newline nil)
        (setq-default js2-global-externs '("module" "ccui" "require" "buster" "sinon" "assert" "refute" "setTimeout" "clearTimeout" "setInterval" "clearInterval" "location" "__dirname" "console" "JSON"))
        (setq-default js2-idle-timer-delay 0.2)
        (setq-default js2-mirror-mode nil)
        (setq-default js2-strict-inconsistent-return-warning nil)
        (setq-default js2-include-rhino-externs nil)
        (setq-default js2-include-gears-externs nil)
        (setq-default js2-concat-multiline-strings 'eol)
        (setq-default js2-rebind-eol-bol-keys nil)
        (setq-default js2-auto-indent-p t)
        (setq-default js2-bounce-indent nil)
        (setq-default js-indent-level 4)
        (setq-default js2-basic-offset 4)
        (setq-default js-switch-indent-offset 4)
        ;; Let flycheck handle parse errors
        (setq-default js2-mode-show-parse-errors nil)
        (setq-default js2-mode-show-strict-warnings nil)
        (setq-default js2-highlight-external-variables t)
        (setq-default js2-strict-trailing-comma-warning nil)
        (setq tags-table-list (list "~/workspace/cp-work-puppeteer/src/TAGS"))
       )
     )
    ))

(defun xingwenju-programming/post-init-python ()
  "Python is a easy and quick language"
  (progn
    (setq python-indent-offset 4)
    (setq python-enable-yapf-format-on-save t)))

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

(defun xingwenju-programming/post-init-pyvenv ()
  (use-package pyvenv
    :config
    (progn
      (dolist (mode '(python-mode hy-mode))
        (spacemacs/set-leader-keys-for-major-mode mode
          "Ea" 'pyvenv-activate
          "Ed" 'pyvenv-deactivate
          "Ew" 'pyvenv-workon)))))
