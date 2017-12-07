;;; config.el --- xingwenju Layer packages File for Spacemacs
;;
;; Copyright (c) 2015-2016 xingwenju
;;
;; Author: xingwenju <xingwenju@gmail.com>
;; URL: https://github.com/xingwenju/spacemacs-private
;;
;; This file is not part of GNU Emacs.
;;
;;; License: GPLv3

(spacemacs|add-toggle iimage
  :status iimage-mode
  :on (iimage-mode)
  :off (iimage-mode -1)
  :documentation "Enable iimage mode"
  :evil-leader "oti")

(add-hook 'term-mode-hook 'xingwenju/ash-term-hooks)


;; reformat your json file, it requires python
(defun beautify-json ()
  (interactive)
  (let ((b (if mark-active (min (point) (mark)) (point-min)))
        (e (if mark-active (max (point) (mark)) (point-max))))
    (shell-command-on-region b e
                             "python -mjson.tool" (current-buffer) t)))




(add-to-list 'auto-mode-alist (cons (concat "\\." (regexp-opt
                                                   '("xml"
                                                     "xsd"
                                                     "rng"
                                                     "xslt"
                                                     "xsl")
                                                   t) "\\'") 'nxml-mode))
(setq nxml-slash-auto-complete-flag t)



(add-to-list 'auto-mode-alist '("\\.mm\\'" . objc-mode))
(add-to-list 'auto-mode-alist '("\\.c\\'" . c++-mode))
(add-to-list 'auto-mode-alist '("\\.txt\\'" . org-mode))


;; return nil to write content to file
(defun xingwenju/untabify-buffer ()
  (interactive)
  (save-excursion
    (untabify (point-min) (point-max)) nil))

(add-hook 'c++-mode-hook
          #'(lambda ()
             (add-hook 'write-contents-hooks
                       'xingwenju/untabify-buffer nil t)))

(setq auto-mode-alist
      (append
       '(("\\.mak\\'" . makefile-bsdmake-mode))
       auto-mode-alist))


(defmacro xingwenju|toggle-company-backends (backend)
  "Push or delete the backend to company-backends"
  (let ((funsymbol (intern (format "zilong/company-toggle-%S" backend))))
    `(defun ,funsymbol ()
       (interactive)
       (if (eq (car company-backends) ',backend)
           (setq-local company-backends (delete ',backend company-backends))
         (push ',backend company-backends)))))