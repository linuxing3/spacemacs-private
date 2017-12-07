;;; org-autoinsert.el --- Autoinsert configuration for orgmode.  -*- lexical-binding: t; -*-

;; Copyright (C) 2016  Chris Barrett

;; Author: Chris Barrett <chris.d.barrett@me.com>

;; Package-Requires: ((s "1.10.0") (dash "2.12.1"))

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;;; Code:

(require 'dash)
(require 's)

(defconst org-autoinsert-form
  '((org-mode . "Org file")
    nil
    "#+TITLE: " (org-autoinsert--file-title) "\n"
    "#+AUTHOR: " user-full-name "\n"
    "\n"))

(defun org-autoinsert--file-title ()
  "Format the title to use for the given FILENAME."
  (->> (file-name-base)
       (s-split-words)
       (-map #'s-capitalized-words)
       (s-join " ")))

;;;###autoload
(defun org-autoinsert-init ()
  (with-eval-after-load 'autoinsert
    (with-no-warnings
      (add-to-list 'auto-insert-alist org-autoinsert-form))))

(provide 'org-autoinsert)

;;; org-autoinsert.el ends here
