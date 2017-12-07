(defun x/insert-plain-text-life-org-template ()
  "This document is available as an [[http://doc.norang.ca/org-mode.org] [org file]]
   which you can load in Emacs and tangle with =C-c C-v C-t= which will create org-mode.el
   in the same directory as the org-mode.org file.  This will extract all of the elisp examples
   in this document into a file you can include in your .emacs file."
  (interactive)
  (load-file "~/.spacemacs.d/org-mode.el")
  )

(defun get-journal-file-today ()
  "Return filename for today's journal entry."
  (let ((daily-name (format-time-string "%Y%m%d")))
    (expand-file-name (concat org-journal-dir daily-name))))

(defun get-journal-text-file-today ()
  "Return filename for today's journal entry with txt."
  (let ((daily-name (format-time-string "%Y%m%d")))
    (expand-file-name (concat org-journal-dir daily-name ".txt"))))

(defun x/journal-file-today ()
  "Create and load a journal file based on today's date. File without extension"
  (interactive)
  (find-file (get-journal-file-today)))

(defun x/journal-text-file-today ()
  "Create and load a journal file based on today's date. File with extension"
  (interactive)
  (find-file (get-journal-text-file-today)))

(defun x/get-journal-file-yesterday ()
  "Return filename for yesterday's journal entry."
  (interactive)
  (let* ((yesterday (time-subtract (current-time) (days-to-time 1)))
         (daily-name (format-time-string "%Y%m%d" yesterday)))
    (expand-file-name (concat org-journal-dir daily-name))))

(defun journal-file-yesterday ()
  "Creates and load a file based on yesterday's date."
  (interactive)
  (find-file (get-journal-file-yesterday)))

(defun x/journal-file-insert ()
  "Insert's the journal heading based on the file's name."
  (interactive)
  (let* ((year  (string-to-number (substring (buffer-name) 0 4)))
         (month (string-to-number (substring (buffer-name) 4 6)))
         (day   (string-to-number (substring (buffer-name) 6 8)))
         (datim (encode-time 0 0 0 day month year)))

    (insert (format-time-string org-journal-date-format datim))
    (insert "\n\n  $0\n") ; Start with a blank separating line
    ))

(defun x/prepare-meeting-notes ()
  "Prepare meeting notes for email
   Take selected region and convert tabs to spaces, mark TODOs with leading >>>, and copy to kill ring for pasting"
  (interactive)
  (let (prefix)
    (save-excursion
      (save-restriction
        (narrow-to-region (region-beginning) (region-end))
        (untabify (point-min) (point-max))
        (goto-char (point-min))
        (while (re-search-forward "^\\( *-\\\) \\(TODO\\|DONE\\): " (point-max) t)
          (replace-match (concat (make-string (length (match-string 1)) ?>) " " (match-string 2) ": ")))
        (goto-char (point-min))
        (kill-ring-save (point-min) (point-max))))))
