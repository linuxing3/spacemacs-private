;; The following setting is different from the document so that you
;; can override the document path by setting your path in the variable
;; org-mode-user-lisp-path
(add-to-list 'auto-mode-alist '("\\.\\(org\\|org_archive\\|txt\\)$" . org-mode))
;;

(if (boundp 'org-user-agenda-files)
    (setq org-agenda-files org-user-agenda-files)
  (setq org-agenda-files (quote ("~/Dropbox/org"
                 "~/Dropbox/org/project"
                 "~/Dropbox/shared"
                 "~/Dropbox/org/personal"))))
;; Here we define the posts dir
(setq org-posts '("~/Dropbox/xingwenju.com/blogs/posts"
             "~/Dropbox/shared"))

;; Here we define the org dir
(setq org-directory "~/Dropbox/org")

;; Here we define the org dir and others
(setq org-agenda-dir "~/Dropbox/org")
(setq org-agenda-file-gtd (expand-file-name "gtd.org" org-agenda-dir))
(setq org-agenda-file-note (expand-file-name "notes.org" org-agenda-dir))
(setq org-agenda-file-journal (expand-file-name "journal.org" org-agenda-dir))
(setq org-agenda-file-code-snippet (expand-file-name "snippet.org" org-agenda-dir))
(setq org-default-notes-file (expand-file-name "gtd.org" org-agenda-dir))

;; (use-package org :ensure t)
;; (use-package org-plus-contrib :ensure t)
;;
;; ;; Org babel Initialization
;; (org-babel-do-load-languages
;;  'org-babel-load-languages
;;  '((shell      . t)
;;    (sh         . t)
;;    (js         . t)
;;    (emacs-lisp . t)
;;    (perl       . t)
;;    (scala      . t)
;;    (clojure    . t)
;;    (python     . t)
;;    (ruby       . t)
;;    (dot        . t)
;;    (css        . t)
;;    (plantuml   . t)))
;;
;; (setq org-confirm-babel-evaluate nil
;;       org-src-fontify-natively t
;;       org-src-tab-acts-natively t)

(setq org-todo-keywords
      (quote ((sequence "TODO(t)" "NEXT(n)" "|" "DONE(d)")
          (sequence "WAITING(w@/!)" "HOLD(h@/!)" "|" "CANCELLED(c@/!)" "PHONE" "MEETING"))))

(setq org-todo-keyword-faces
      (quote (("TODO" :foreground "red" :weight bold)
       ("NEXT" :foreground "blue" :weight bold)
          ("DONE" :foreground "forest green" :weight bold)
          ("WAITING" :foreground "orange" :weight bold)
          ("HOLD" :foreground "magenta" :weight bold)
          ("CANCELLED" :foreground "forest green" :weight bold)
          ("MEETING" :foreground "forest green" :weight bold)
          ("PHONE" :foreground "forest green" :weight bold))))

(setq org-use-fast-todo-selection t)

(setq org-treat-S-cursor-todo-selection-as-state-change nil)

(setq org-todo-state-tags-triggers
      (quote (("CANCELLED" ("CANCELLED" . t))
          ("WAITING" ("WAITING" . t))
          ("HOLD" ("WAITING") ("HOLD" . t))
          (done ("WAITING") ("HOLD"))
          ("TODO" ("WAITING") ("CANCELLED") ("HOLD"))
          ("NEXT" ("WAITING") ("CANCELLED") ("HOLD"))
          ("DONE" ("WAITING") ("CANCELLED") ("HOLD")))))

(setq org-capture-templates
      '(
    ;; ==================================
    ("t" "待办Todo" entry (file+headline org-agenda-file-gtd "Inbox")
     "** TODO [#B] %?\t%^g\n  %i\n"
     :empty-lines 1)
    ;; ==================================
    ("P" "Project" entry (file+headline org-agenda-file-gtd "Project")
     "** TODO [#B] %? [/]\t%^g\n - [ ] Protocolo\n - [ ] Paper\n - [ ] Press \n - [ ] Logistic\n - [ ] Misc\n"
     :empty-lines 1)
    ;; ==================================
    ("n" "笔记Notes" entry (file+headline org-agenda-file-note "Quick notes")
     "** %?\t%^g\n  %i\n %U"
     :empty-lines 1)
    ;; ==================================
     ("L" "Bookmark" entry (file+headline org-agenda-file-note "Inbox")
    "* %? [[%:link][%:description]] \nCaptured On: %U")
          ("p" "Protocol" entry (file+headline org-agenda-file-note "Inbox")
    "* %^{Title}\nSource: %u, %c\n #+BEGIN_QUOTE\n%i\n#+END_QUOTE\n\n\n%?")
    ("c" "Chrome" entry (file+headline org-agenda-file-note "Quick notes")
    "** TODO [#C] %?\n %(xingwenju/retrieve-chrome-current-tab-url)\n %i\n %U"
    :empty-lines 1)
    ;; ==================================
    ("r" "回复Response" entry (file+headline org-agenda-file-gtd "Inbox")
    "** TODO %?\t%^g\nSCHEDULED: %t\n%U\n%a\n" :clock-in t :clock-resume t)
    ;; ==================================
    ("s" "代码片段Code Snippet" entry
     (file org-agenda-file-code-snippet)
     "* %?\t%^g\n#+BEGIN_SRC %^{language}\n\n#+END_SRC")
    ;; ==================================
    ("j" "日志Journal"
     entry (file+olp+datetree org-agenda-file-journal)
     "* %?"
     :empty-lines 1)
    ;; End of Template
))



(use-package org-pomodoro
:ensure t
)

(setq org-agenda-custom-commands
  '(
    ("w" . "任务安排")
      ("wa" "重要且紧急的任务" tags-todo "+PRIORITY=\"A\"")
      ("wb" "重要且不紧急的任务" tags-todo "-Weekly-Monthly-Daily+PRIORITY=\"B\"")
      ("wc" "不重要且紧急的任务" tags-todo "+PRIORITY=\"C\"")
    ("b" "写作" tags "BLOG")
    ("p" . "项目安排")
      ("pw" tags-todo "dev")
      ("pl" tags-todo "dev+PROJECT")
    ("d" . "孩子安排")
      ("da" "紧急" tags-todo "kid+PRIORITY=\"A\"")
      ("db" "普通" tags-todo "kid")
    ("h" "家务安排" tags-todo "home")
    ("W" "每周回顾"
     ((stuck "") ;; review stuck projects as designated by org-stuck-projects
  (tags "project") ;; review all projects (assuming you use todo keywords to designate projects)
  ))))

(setq org-use-speed-commands t
    org-return-follows-link t
    org-hide-emphasis-markers t
    org-completion-use-ido t
    org-outline-path-complete-in-steps nil
    org-src-fontify-natively t   ;; Pretty code blocks
    org-src-tab-acts-natively t
    org-confirm-babel-evaluate nil ;; No code evaluation confirm
  )

(setq org-agenda-inhibit-startup t) ;; ~50x speedup
(setq org-agenda-span 'day)
(setq org-agenda-use-tag-inheritance nil) ;; 3-4x speedup
(setq org-agenda-window-setup 'current-window)
(setq org-log-done t)

;; more applications
  (setq org-file-apps
  (append '(
        ("\\.pdf\\'" . "evince %s")
        ) org-file-apps ))

(use-package org-ac
  :ensure t
  :init (progn
      (require 'org-ac)
      (org-ac/config-default)
      ))

(setq org-refile-use-outline-path 'file)
(setq org-outline-path-complete-in-steps nil)

(setq org-refile-targets
  '((nil :maxlevel . 4)
    (org-posts :maxlevel . 4)
    (org-agenda-files :maxlevel . 4)))

(setq org-archive-location "~/Dropbox/org/archived/%s_archive::")

;; bullets
  (use-package org-bullets
  :ensure t
  :config
  (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1))))

(use-package org-journal
   :ensure t)
(setq org-journal-dir "~/Dropbox/org/journal/")
(setq org-journal-date-format "#+TITLE: Journal Entry- %e %b %Y (%A)")
(setq org-journal-time-format "")

(defun journal-file-insert ()
  "Insert's the journal heading based on the file's name."
  (interactive)
  (let* ((year  (string-to-number (substring (buffer-name) 0 4)))
     (month (string-to-number (substring (buffer-name) 4 6)))
     (day   (string-to-number (substring (buffer-name) 6 8)))
     (datim (encode-time 0 0 0 day month year)))

  (insert (format-time-string org-journal-date-format datim))
  (insert "\n\n  $0\n") ; Start with a blank separating line

  ;; Note: The `insert-file-contents' leaves the cursor at the
  ;; beginning, so the easiest approach is to insert these files
  ;; in reverse order:

  ;; If the journal entry I'm creating matches today's date:
  (when (equal (file-name-base (buffer-file-name))
           (format-time-string "%Y%m%d"))
    (insert-file-contents "journal-dailies-end.org")

    ;; Insert dailies that only happen once a week:
    (let ((weekday-template (downcase
                 (format-time-string "journal-%a.org"))))
      (when (file-exists-p weekday-template)
    (insert-file-contents weekday-template)))
    (insert-file-contents "journal-dailies.org")
    (insert "$0")

    (let ((contents (buffer-string)))
      (delete-region (point-min) (point-max))
      (yas-expand-snippet contents (point-min) (point-max))))))

(define-auto-insert "/[0-9]\\{8\\}$" [journal-file-insert])

(defun get-journal-file-today ()
  "Return filename for today's journal entry."
  (let ((daily-name (format-time-string "%Y%m%d")))
(expand-file-name (concat org-journal-dir daily-name))))

(defun get-journal-text-file-today ()
  "Return filename for today's journal entry with txt."
  (let ((daily-name (format-time-string "%Y%m%d")))
(expand-file-name (concat org-journal-dir daily-name ".txt"))))

(defun journal-file-today ()
  "Create and load a journal file based on today's date. File without extension"
  (interactive)
  (find-file (get-journal-file-today)))

(defun journal-text-file-today ()
  "Create and load a journal file based on today's date. File with extension"
  (interactive)
  (find-file (get-journal-text-file-today)))

(defun get-journal-file-yesterday ()
  "Return filename for yesterday's journal entry."
  (interactive)
  (let* ((yesterday (time-subtract (current-time) (days-to-time 1)))
     (daily-name (format-time-string "%Y%m%d" yesterday)))
(expand-file-name (concat org-journal-dir daily-name))))

(defun journal-file-yesterday ()
  "Creates and load a file based on yesterday's date."
  (interactive)
  (find-file (get-journal-file-yesterday)))

(defun journal-last-year-file ()
  "Returns the string corresponding to the journal entry that
happened 'last year' at this same time (meaning on the same day
of the week)."
(let* ((last-year-seconds (- (float-time) (* 365 24 60 60)))
   (last-year (seconds-to-time last-year-seconds))
   (last-year-dow (nth 6 (decode-time last-year)))
   (this-year-dow (nth 6 (decode-time)))
   (difference (if (> this-year-dow last-year-dow)
           (- this-year-dow last-year-dow)
         (- last-year-dow this-year-dow)))
   (target-date-seconds (+ last-year-seconds (* difference 24 60 60)))
   (target-date (seconds-to-time target-date-seconds)))
  (format-time-string "%Y%m%d" target-date)))

(defun journal-last-year ()
  "Loads last year's journal entry, which is not necessary the
same day of the month, but will be the same day of the week."
  (interactive)
  (let ((journal-file (concat org-journal-dir (journal-last-year-file))))
(find-file journal-file)))

(defun meeting-notes ()
  "Call this after creating an org-mode heading for where the notes for the meeting
should be. After calling this function, call 'meeting-done' to reset the environment."
  (interactive)
  (outline-mark-subtree)                              ;; Select org-mode section
  (narrow-to-region (region-beginning) (region-end))  ;; Only show that region
  (deactivate-mark)
  (delete-other-windows)                              ;; Get rid of other windows
  (text-scale-set 2)                                  ;; Text is now readable by others
  (fringe-mode 0)
  (message "When finished taking your notes, run meeting-done."))

(defun meeting-done ()
  "Attempt to 'undo' the effects of taking meeting notes."
  (interactive)
  (widen)                                       ;; Opposite of narrow-to-region
  (text-scale-set 0)                            ;; Reset the font size increase
  (fringe-mode 1)
  (winner-undo))                                ;; Put the windows back in place

(defadvice org-capture-finalize
(after delete-capture-frame activate)
"Advise capture-finalize to close the frame"
(if (equal "capture" (frame-parameter nil 'name))
(delete-frame)))

(defadvice org-capture-destroy
(after delete-capture-frame activate)
"Advise capture-destroy to close the frame"
(if (equal "capture" (frame-parameter nil 'name))
(delete-frame)))

(use-package noflet
:ensure t )

(defun make-capture-frame ()
"Create a new frame and run org-capture."
(interactive)
(make-frame '((name . "capture")))
(select-frame-by-name "capture")
(delete-other-windows)
(noflet ((switch-to-buffer-other-window (buf) (switch-to-buffer buf)))
(org-capture)))

(global-set-key "\C-ca" 'org-agenda)
(global-set-key (kbd "C-c c") 'org-capture)
(global-set-key (kbd "<f7>") 'org-w3m-copy-for-org-mode)

(define-key org-mode-map (kbd "s-p") 'org-priority)

(define-key evil-normal-state-map (kbd "C-c C-w") 'org-refile)
;; (define-key evil-normal-state-map (kbd "C-c C-W") 'org-archive-subtree)
