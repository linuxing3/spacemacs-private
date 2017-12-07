;; init-feed.el --- Initialize basic configurations.	-*- lexical-binding: t -*-
;;
;; Author: Vincent Zhang <seagle0128@gmail.com>
;; Version: 3.1.0
;; URL: https://github.com/seagle0128/.emacs.d
;; Keywords:
;; Compatibility:
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;; Commentary:
;;             Elfeed configurations.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; This program is free software; you can redistribute it and/or
;; modify it under the terms of the GNU General Public License as
;; published by the Free Software Foundation; either version 2, or
;; (at your option) any later version.
;;
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
;; General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with this program; see the file COPYING.  If not, write to
;; the Free Software Foundation, Inc., 51 Franklin Street, Fifth
;; Floor, Boston, MA 02110-1301, USA.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;; Code:

(use-package elfeed
    :ensure t
    :config
    (setq elfeed-db-directory "~/Dropbox/shared/elfeeddb")
    (setq elfeed-feeds
        '("http://nullprogram.com/feed/"
             "http://jr0cket.co.uk/atom.xml"
             "https://linuxing3.github.io/rss.xml"
             "http://ergoemacs.org/emacs/blog.xml"
             "http://planet.emacsen.org/atom.xml"))
    )


;; wget https://github.com/remyhonig/elfeed-org/blob/master/elfeed-org.el
(use-package elfeed-org
    :ensure t
    :config
    (setq rmh-elfeed-org-files (list
                                   "~/Dropbox/config/emacs/literate/xingwenju-elfeed-resource.org"
                                   )))
(provide 'init-feed)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; init-feed.el ends here
