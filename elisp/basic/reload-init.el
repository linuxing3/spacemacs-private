(defun xingwenju/reload-init ()
  "Reload the init file"
  (interactive)
  (load-file "~/Dropbox/config/emacs/common/init.el")
  )

(defun xingwenju/set-bookmark-file ()
  "Load the bookmark file"
  (interactive)
  (setq bookmark-file "~/Dropbox/shared/emacs-bookmarks")
  (bookmark-load bookmark-file)
  )

; if you're windened, narrow to the region, if you're narrowed, widen
; bound to C-x n
(defun narrow-or-widen-dwim (p)
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

;; eshell here
(defun eshell-here ()
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

(global-set-key (kbd "C-!") 'eshell-here)

(defun load-if-exists (f)
  "load the elisp file only if it exists and is readable"
  (if (file-readable-p f)
  (load-file f)))

(defun babel-load-if-exists (f)
  "babel load the elisp file only if it exists and is readable"
  (if (file-readable-p f)
  (org-babel-load-file f)))

(load-if-exists "~/Dropbox/config/emacs/modules/services/ssh-tunnel.el")
(load-if-exists "~/Dropbox/config/emacs/modules/services/xingwenju-email.el")
(load-if-exists "~/Dropbox/config/emacs/common/aliases.el")

(babel-load-if-exists "~/Dropbox/config/emacs/common/xingwenju-helpers.org")

(defun xingwenju/reload-init ()
  "Reload the init file"
  (interactive)
  (load-file "~/Dropbox/config/emacs/common/init.el")
  )

(defun xingwenju/set-bookmark-file ()
  "Load the bookmark file"
  (interactive)
  (setq bookmark-file "~/Dropbox/shared/emacs-bookmarks")
  (bookmark-load bookmark-file)
  )


(defun xingwenju/load-library ()
"Load some library of reveal"
(interactive)
(load-library "ox-reveal")
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

(defun xingwenju/nikola-deploy ()
  "Nikola deploy to Github Page"
  (interactive)
  (shell-command "cd ~/Dropbox/xingwenju.com/blogs; nikola github_deploy")
  )

(defun xingwenju/nikola-serve ()
  "Nikola serve with local server"
  (interactive)
  (shell-command "cd ~/Dropbox/xingwenju.com/blogs; nikola serve -p 9999 &")
  )

(defun xingwenju/nikola-build ()
  "Nikola build new pages"
  (interactive)
  (shell-command "cd ~/Dropbox/xingwenju.com/blogs; nikola build &")
  )
