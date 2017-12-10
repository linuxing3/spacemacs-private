;; funcs.el --- xingwenju layer functions configurations.	-*- lexical-binding: t -*-
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;; Commentary:
;;             Custom configurations.
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
;; along with this program; see the custom-file COPYING.  If not, write to
;; the Free Software Foundation, Inc., 51 Franklin Street, Fifth
;; Floor, Boston, MA 02110-1301, USA.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;; Code:

(defun x/load-custom-file-system-type ()
  "Load custom file according the system type"
  (interactive)
  (cond
   ;; checke the system type
   ((eq system-type 'darwin)
    (progn
      (setq custom-file (expand-file-name "custom.mac.el" dotspacemacs-directory))
      ))
   ((eq system-type 'windows-nt)
    (progn
      (setq custom-file (expand-file-name "custom.win.el" dotspacemacs-directory))
      ))
   ((eq system-type 'gnu/linux)
    (progn
      (setq custom-file (expand-file-name "custom.linux.el" dotspacemacs-directory))
      ))
   )

  ;; Load the custom file
  (if (file-exists-p custom-file)
      (message (format "%s" custom-file))
    (load custom-file 'no-error 'no-message)
    )
  )

(defun org-agenda-show-agenda-and-todo (&optional arg)
  (interactive "P")
  (org-agenda arg "c")
  (org-agenda-fortnight-view))

(defun x/org-headline-to-top ()
  (interactive)
  ;; check if we are at the top level
  (let ((lvl (org-current-level)))
    (cond
     ;; above all headlines so nothing to do
     ((not lvl)
      (message "No headline to move"))
     ((= lvl 1)
      ;; if at top level move current tree to go above first headline
      (org-cut-subtree)
      (beginning-of-buffer)
      ;; test if point is now at the first headline and if not then
      ;; move to the first headline
      (unless (looking-at-p "*")
        (org-next-visible-heading 1))
      (org-paste-subtree))
     ((> lvl 1)
      ;; if not at top level then get position of headline level above
      ;; current section and refile to that position. Inspired by
      ;; https://gist.github.com/alphapapa/2cd1f1fc6accff01fec06946844ef5a5
      (let* ((org-reverse-note-order t)
             (pos (save-excursion
                    (outline-up-heading 1)
                    (point)))
             (filename (buffer-file-name))
             (rfloc (list nil filename nil pos)))
        (org-refile nil nil rfloc))))))

(defun x/org-agenda-item-to-top ()
   "移动当前项到日历第一行"
  (interactive)
  ;; save buffers to preserve agenda
  (org-save-all-org-buffers)
  ;; switch to buffer for current agenda item
  (org-agenda-switch-to)
  ;; move item to top
  (bjm/org-headline-to-top)
  ;; go back to agenda view
  (switch-to-buffer (other-buffer (current-buffer) 1))
  ;; refresh agenda
  (org-agenda-redo)
  )

(defun x/change-el-to-org (from-file-name directory)
  "Recursively change el files to org files for tangle"
  (interactive)
  (let ((to-file-name from-file-name) (default-directory directory))
    (switch-to-buffer-other-window "*temp*")
    (erase-buffer)
    (insert-file-contents from-file-name)
    (goto-char (point-min))
    (insert (concat "* " from-file-name " configurations"))
    (insert "\n\n#+BEGIN_SRC emacs-lisp\n\n")
    (goto-char (point-max))
    (insert "\n#+END_SRC\n")
    (goto-char (point-min))
    (write-file (concat to-file-name ".org"))
    (other-window 1)
    ))


(defun x/walk (directory)
 "Walk a directory and apply function to each file"
  (interactive)
  (mapcar
      (lambda (elm)
          (unless (or (string= elm ".") (string= elm ".."))
                  (funcall 'x/change-el-to-org elm directory)))
      (directory-files directory)
  )
)

(defun x/walk-and-load (directory)
 "Walk a directory and apply function to each file"
  (interactive)
  (mapcar
      (lambda (elm)
          (unless (or (string= elm ".") (string= elm ".."))
                  (funcall 'babel-load-if-exists elm)))
      (directory-files directory)
  )
)

;; Unit Test:

;; (setq default-directory "~/lisp")
;; (walk-and-load "~/Dropbox/config/emacs/centaur/lisp")
;; (walk "~/lisp")

(defun gtd ()
  (interactive)
  (find-file "~/Dropbox/org/gtd.org"))

(defun work ()
  (interactive)
  (find-file "~/Dropbox/org/todo.org"))

(defun private ()
  (interactive)
  (find-file "~/Dropbox/org/xingwenju.org"))

(defun kid ()
  (interactive)
  (find-file "~/Dropbox/org/daniel.org"))

(defun code ()
  (interactive)
  (find-file "~/Dropbox/org/snippet.org"))

(defun note ()
  (interactive)
  (find-file "~/Dropbox/org/notes.org"))

(defun journal ()
  (interactive)
  (find-file "~/Dropbox/org/journal.org"))

(defun common-init-file ()
  (interactive)
  (find-file "~/Dropbox/config/emacs/common/init.el"))

(defun writer-init-file ()
  (interactive)
  (find-file "~/Dropbox/config/emacs/writer/init-main.el"))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; funcs.el ends here
