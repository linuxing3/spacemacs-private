;;; packages.el --- xingwenju-org layer packages file for Spacemacs.
;;
;; Copyright (c) 2012-2017 Sylvain Benner & Contributors
;;
;; Author: Xing Wenju <xignwenju@gmail.com>
;; URL: https://github.com/syl20bnr/spacemacs
;;
;; This file is not part of GNU Emacs.
;;
;;; License: GPLv3

(defconst xingwenju-org-packages
  '(
    calfw
    calfw-org
    )
  )

(defun xingwenju-org/init-calfw ()
  ""
  (progn
    (use-package calfw :ensure t)
    (use-package calfw-org :ensure t)
    )
  )
