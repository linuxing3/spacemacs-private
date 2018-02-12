(defun x/load-custom-file-system-type ()
  "Load custom file according the system type"
  (interactive)
  (setq custom-files-list '(
                            (windows-nt . "win")
                            (darwin . "mac")
                            (linux . "linux")
                            ))
  (setq custom-file (expand-file-name
                     (concat "custom/custom." (alist-get system-type custom-files-list) ".el")
                     dotspacemacs-directory))
  ;; Load the custom file
  (if (file-exists-p custom-file)
      (message (format "%s" custom-file))
    (load custom-file 'no-error 'no-message)))
