(defun x/narrow-or-widen-dwim (p)
  "If the buffer is narrowed, it widens. Otherwise, it narrows intelligently.
Intelligently means: region, org-src-block, org-subtree, or defun,
whichever applies first.
Narrowing to org-src-block actually calls `org-edit-src-code'.

With prefix P, don't widen, just narrow even if buffer is already
narrowed."
  (interactive "P")
  (declare (interactive-only))
  (cond ((and (buffer-narrowed-p) (not p)) (widen))
        ((region-active-p)
         (narrow-to-region (region-beginning) (region-end)))
        ((derived-mode-p 'org-mode)
         ;; `org-edit-src-code' is not a real narrowing command.
         ;; Remove this first conditional if you don't want it.
         (cond ((ignore-errors (org-edit-src-code))
                (delete-other-windows))
               ((org-at-block-p)
                (org-narrow-to-block))
               (t (org-narrow-to-subtree))))
        (t (narrow-to-defun))))

(defun x/tex-file-view ()
    (interactive)
    (tex-send-command "evince" (tex-append tex-print-file ".pdf")))

(defun x/eshell-here ()
  "Opens up a new shell in the directory associated with the
current buffer's file. The eshell is renamed to match that
directory to make multiple eshell windows easier."
  (interactive)
  (let* ((parent (if (buffer-file-name)
             (file-name-directory (buffer-file-name))
           default-directory))
     (height (/ (window-total-height) 3))
     (name   (car (last (split-string parent "/" t)))))
    (split-window-vertically (- height))
    (other-window 1)
    (eshell "new")
    (rename-buffer (concat "*eshell: " name "*"))

    (insert (concat "ls"))
    (eshell-send-input)))

(defcustom dotemacs-eshell/prompt-git-info
  t
  "Turns on additional git information in the prompt."
  :group 'dotemacs-eshell
  :type 'boolean)

;; (epe-colorize-with-face "abc" 'font-lock-comment-face)
(defmacro epe-colorize-with-face (str face)
  `(propertize ,str 'face ,face))

(defface epe-venv-face
  '((t (:inherit font-lock-comment-face)))
  "Face of python virtual environment info in prompt."
  :group 'epe)

  (setq eshell-prompt-function
      (lambda ()
    (concat (propertize (abbreviate-file-name (eshell/pwd)) 'face 'eshell-prompt)
        (when (and dotemacs-eshell/prompt-git-info
               (fboundp #'vc-git-branches))
          (let ((branch (car (vc-git-branches))))
            (when branch
              (concat
               (propertize " [" 'face 'font-lock-keyword-face)
               (propertize branch 'face 'font-lock-function-name-face)
               (let* ((status (shell-command-to-string "git status --porcelain"))
                  (parts (split-string status "\n" t " "))
                  (states (mapcar #'string-to-char parts))
                  (added (count-if (lambda (char) (= char ?A)) states))
                  (modified (count-if (lambda (char) (= char ?M)) states))
                  (deleted (count-if (lambda (char) (= char ?D)) states)))
             (when (> (+ added modified deleted) 0)
               (propertize (format " +%d ~%d -%d" added modified deleted) 'face 'font-lock-comment-face)))
               (propertize "]" 'face 'font-lock-keyword-face)))))
        (when (and (boundp #'venv-current-name) venv-current-name)
          (concat
            (epe-colorize-with-face " [" 'epe-venv-face)
            (propertize venv-current-name 'face `(:foreground "#2E8B57" :slant italic))
            (epe-colorize-with-face "]" 'epe-venv-face)))
        (propertize " $ " 'face 'font-lock-constant-face))))

(defun x/load-if-exists (f)
  "load the elisp file only if it exists and is readable"
  (if (file-readable-p f)
  (load-file f)))

(defun x/babel-load-if-exists (f)
  "babel load the elisp file only if it exists and is readable"
  (if (file-readable-p f)
  (org-babel-load-file f)))

(defun x/reload-init ()
  "Reload the init file"
  (interactive)
  (load-file "~/.emacs.d/init.el")
  )

(defun x/set-bookmark-file ()
  "Load the bookmark file"
  (interactive)
  (setq bookmark-file "~/Dropbox/shared/emacs-bookmarks")
  (bookmark-load bookmark-file)
  )
(defun set-w3m-command ()
  "Set the w3m-command for different OS"
  (if (string-equal system-type "darwin")
    (setq w3m-command "/usr/local/Cellar/w3m/0.5.3/bin/w3m"))
  (if (string-equal system-type "gnu/linux")
    (setq w3m-command "/usr/local/bin/w3m"))
  (if (string-equal system-type "windows-nt")
    (setq w3m-command "c:\var\w3m\bin\w3m"))
)
