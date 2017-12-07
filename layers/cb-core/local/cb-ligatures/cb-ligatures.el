;;; cb-ligatures.el --- Use Hasklig to provide ligatures.  -*- lexical-binding: t; -*-

;; Copyright (C) 2016  Chris Barrett

;; Author: Chris Barrett <chris.d.barrett@me.com>
;; Package-Requires: ((dash "2.12.1"))

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

(defconst cb-ligatures--alist
  (list (cons "&&" (decode-char 'ucs #XE100))
        (cons "***" (decode-char 'ucs #XE101))
        (cons "*>" (decode-char 'ucs #XE102))
        (cons "\\\\" (decode-char 'ucs #XE103))
        (cons "||" (decode-char 'ucs #XE104))
        (cons "|>" (decode-char 'ucs #XE105))
        (cons "::" (decode-char 'ucs #XE106))
        (cons "==" (decode-char 'ucs #XE107))
        (cons "===" (decode-char 'ucs #XE108))
        (cons "==>" (decode-char 'ucs #XE109))
        (cons "=>" (decode-char 'ucs #XE10A))
        (cons "=<<" (decode-char 'ucs #XE10B))
        (cons "!!" (decode-char 'ucs #XE10C))
        (cons ">>" (decode-char 'ucs #XE10D))
        (cons ">>=" (decode-char 'ucs #XE10E))
        (cons ">>>" (decode-char 'ucs #XE10F))
        (cons ">>-" (decode-char 'ucs #XE110))
        (cons ">-" (decode-char 'ucs #XE111))
        (cons "->" (decode-char 'ucs #XE112))
        (cons "-<" (decode-char 'ucs #XE113))
        (cons "-<<" (decode-char 'ucs #XE114))
        (cons "<*" (decode-char 'ucs #XE115))
        (cons "<*>" (decode-char 'ucs #XE116))
        (cons "<|" (decode-char 'ucs #XE117))
        (cons "<|>" (decode-char 'ucs #XE118))
        (cons "<$>" (decode-char 'ucs #XE119))
        (cons "<>" (decode-char 'ucs #XE11A))
        (cons "<-" (decode-char 'ucs #XE11B))
        (cons "<<" (decode-char 'ucs #XE11C))
        (cons "<<<" (decode-char 'ucs #XE11D))
        (cons "<+>" (decode-char 'ucs #XE11E))
        (cons ".." (decode-char 'ucs #XE11F))
        (cons "..." (decode-char 'ucs #XE120))
        (cons "++" (decode-char 'ucs #XE121))
        (cons "+++" (decode-char 'ucs #XE122))
        (cons "/=" (decode-char 'ucs #XE123))))

;;;###autoload
(defun cb-ligatures-init ()
  (when (equal "Hasklig" (ignore-errors (font-get (face-attribute 'default :font) :name)))
    (setq-default prettify-symbols-alist (-union prettify-symbols-alist
                                                 cb-ligatures--alist))))

(provide 'cb-ligatures)

;;; cb-ligatures.el ends here
