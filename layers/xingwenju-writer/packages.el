;;; packages.el --- xingwenju-writer layer packages file for Spacemacs.
;;
;; Copyright (c) 2012-2017 Sylvain Benner & Contributors
;;
;; Author:  <ShiYongRen@03-1302940>
;; URL: https://github.com/syl20bnr/spacemacs
;;
;; This file is not part of GNU Emacs.
;;
;;; License: GPLv3

;;; Commentary:

;; See the Spacemacs documentation and FAQs for instructions on how to implement
;; a new layer:
;;
;;   SPC h SPC layers RET
;;
;;
;; Briefly, each package to be installed or configured by this layer should be
;; added to `xingwenju-writer-packages'. Then, for each package PACKAGE:
;;
;; - If PACKAGE is not referenced by any other Spacemacs layer, define a
;;   function `xingwenju-writer/init-PACKAGE' to load and initialize the package.

;; - Otherwise, PACKAGE is already referenced by another Spacemacs layer, so
;;   define the functions `xingwenju-writer/pre-init-PACKAGE' and/or
;;   `xingwenju-writer/post-init-PACKAGE' to customize the package as it is loaded.

;;; Code:

(defconst xingwenju-writer-packages
  '(
    org
    org-journal
    ox-reveal
    nikola
    org-tree-slide
    easy-hugo
    )
  )


(defun xingwenju-writer/post-init-ox-reveal ()
  "Automatically load ox reveal library"
  (progn
    (use-package ox-reveal
      :ensure nil
      :after ox
      :init
      (load-library "ox-reveal")
      :config
      (setq org-reveal-root "http://cdn.jsdelivr.net/reveal.js/3.0.0/")
      )
    )
  )

(defun xingwenju-writer/init-easy-hugo ()
  "Start hugo support and load library"
  (use-package easy-hugo
    :ensure t
    :init
    (setq easy-hugo-basedir "~/Dropbox/xingwenju.com/hugo/")
    (setq easy-hugo-postdir "content/feeds")
    (setq easy-hugo-url "https://linuxing3.github.io")
    (setq easy-hugo-sshdomain "mini")
    (setq easy-hugo-root "/home/blog/")
    (setq easy-hugo-default-ext ".org")
    (setq easy-hugo-previewtime "300"))
  )


(defun xingwenju-writer/post-init-org ()
   "Setting org as I want"
    ;; More
    (with-eval-after-load 'org
        (progn

          ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
          ;; Basic bindings
          ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
         (use-package org
           :config
           ;;;start;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
           (bind-keys :map org-mode-map
                      ("A-b" . (surround-text-with "+"))
                      ("s-b" . (surround-text-with "*"))
                      ("A-i" . (surround-text-with "/"))
                      ("s-i" . (surround-text-with "/"))
                      ("A-=" . (surround-text-with "="))
                      ("s-=" . (surround-text-with "="))
                      ("A-`" . (surround-text-with "~"))
                      ("s-`" . (surround-text-with "~"))
                      ("C-s-f" . forward-sentence)
                      ("C-s-b" . backward-sentence))
           (font-lock-add-keywords            ; A bit silly but my headers are now
            'org-mode `(("^\\*+ \\(TODO\\) "  ; shorter, and that is nice canceled
                         (1 (progn (compose-region (match-beginning 1) (match-end 1) "⚑")
                                   nil)))
                        ("^\\*+ \\(DOING\\) "
                         (1 (progn (compose-region (match-beginning 1) (match-end 1) "⚐")
                                   nil)))
                        ("^\\*+ \\(CANCELED\\) "
                         (1 (progn (compose-region (match-beginning 1) (match-end 1) "✘")
                                   nil)))
                        ("^\\*+ \\(DONE\\) "
                         (1 (progn (compose-region (match-beginning 1) (match-end 1) "✔")
                                   nil)))))
           ;;;end;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
           )
          ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
         ;; file structure
          ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
          (if (boundp 'org-user-agenda-files)
              (setq org-agenda-files org-user-agenda-files)
            (setq org-agenda-files (quote ("~/Dropbox/org"
                                           "~/Dropbox/org/project"
                                           "~/Dropbox/org/brain"
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
          (setq org-agenda-file-todo (expand-file-name "todo.org" org-agenda-dir))
          (setq org-agenda-file-note (expand-file-name "notes.org" org-agenda-dir))
          (setq org-agenda-file-links (expand-file-name "links.org" org-agenda-dir))
          (setq org-agenda-file-datetree (expand-file-name "datetree.org" org-agenda-dir))
          (setq org-agenda-file-code-snippet (expand-file-name "snippet.org" org-agenda-dir))
          (setq org-default-notes-file (expand-file-name "gtd.org" org-agenda-dir))

          ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
          ;; config refile targets
          ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
          (setq org-refile-use-outline-path 'file)
          (setq org-outline-path-complete-in-steps nil)

          (setq org-refile-targets
                '((nil :maxlevel . 4)
                  (org-agenda-files :maxlevel . 4)))

          ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
          ;; archive location
          ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
          (setq org-archive-location "~/Dropbox/org/archived/%s_archive::")

          ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
          ;; config stuck project
          ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
          (setq org-stuck-projects
                '("TODO={.+}/-DONE" nil nil "SCHEDULED:\\|DEADLINE:"))

          ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
          ;; config agenda 
          ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
          (setq org-agenda-inhibit-startup t) ;; ~50x speedup
          (setq org-agenda-span 'day)
          (setq org-agenda-use-tag-inheritance nil) ;; 3-4x speedup
          (setq org-agenda-window-setup 'current-window)
          (setq org-log-done t)
          (with-eval-after-load 'org-agenda
            (define-key org-agenda-mode-map (kbd "P") 'org-pomodoro)
            (spacemacs/set-leader-keys-for-major-mode 'org-agenda-mode
              "." 'spacemacs/org-agenda-transient-state/body)
            )

          ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
          ;; config org-mode for files 
          ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
          (add-to-list 'auto-mode-alist '("\\.\\(org\\|org_archive\\|txt\\)$" . org-mode))

          ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
          ;; config todo keywords
          ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
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

          (setq org-todo-state-tags-triggers
                (quote (("CANCELLED" ("CANCELLED" . t))
                        ("WAITING" ("WAITING" . t))
                        ("HOLD" ("WAITING") ("HOLD" . t))
                        (done ("WAITING") ("HOLD"))
                        ("TODO" ("WAITING") ("CANCELLED") ("HOLD"))
                        ("NEXT" ("WAITING") ("CANCELLED") ("HOLD"))
                        ("DONE" ("WAITING") ("CANCELLED") ("HOLD")))))
          ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
          ;; Org clock
          ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

          ;; Change task state to STARTED when clocking in
          (setq org-clock-in-switch-to-state "STARTED")
          ;; Save clock data and notes in the LOGBOOK drawer
          (setq org-clock-into-drawer t)
          ;; Removes clocked tasks with 0:00 duration
          (setq org-clock-out-remove-zero-time-clocks t) ;; Show the clocked-in task - if any - in the header line

          (setq org-tags-match-list-sublevels nil)

          (add-hook 'org-mode-hook '(lambda ()
                                      ;; keybinding for editing source code blocks
                                      ;; keybinding for inserting code blocks
                                      (local-set-key (kbd "C-c i s")
                                                     'x/simple-org-insert-src-block)))

          ;;reset subtask
          (setq org-default-properties (cons "RESET_SUBTASKS" org-default-properties))

          ;; (add-hook 'org-after-todo-state-change-hook 'org-subtask-reset)

          ;; (setq org-plantuml-jar-path
          ;;       (expand-file-name "~/.spacemacs.d/plantuml.jar"))
          ;; (setq org-ditaa-jar-path "~/.spacemacs.d/ditaa.jar")


          ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
          ;; Org babel stuff
          ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
          (org-babel-do-load-languages
           'org-babel-load-languages
           '(
             (shell . t)
             (python . t)
             (emacs-lisp . t)
             ;; (dot . t)
             ;; (plantuml . t)
             ;; (ditaa . t)
             ))

          (eval-after-load 'org-src
            '(define-key org-src-mode-map
               (kbd "C-x C-s") #'org-edit-src-exit))

          ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
          ;; Capture templates
          ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

          (setq org-capture-templates
                '(
              ;; ==================================
              ("t" "待办 @Todo" entry (file org-agenda-file-gtd)
               "* TODO [#B] %?\t%^g\n  %i\n"
               :clock-in t
               :clock-resume t
               :empty-lines 1)
              ;; ==================================
              ("p" "项目 @ Project" entry (file+headline org-agenda-file-todo "项目 Projects")
               "** TODO [#B] %? [/]\t%^g\n - [ ] Protocolo\n - [ ] Paper\n - [ ] Press \n - [ ] Logistic\n - [ ] Misc\n"
               :empty-lines 1)
              ;; ==================================
              ("s" "代码片段 @Code Snippet" entry
               (file org-agenda-file-code-snippet)
               "* %?\t%^g\n#+BEGIN_SRC %^{language}\n\n#+END_SRC")
              ;; ==================================
               ("l" "书签 @Bookmark" entry (file org-agenda-file-links)
              "* %? [[%:link][%:description]] \nCaptured On: %U")
              ("q" "源 @Source" entry (file org-agenda-file-links)
              "* %^{Title}\nSource: %u, %c\n #+BEGIN_QUOTE\n%i\n#+END_QUOTE\n\n\n%?\n%F")
              ("c" "浏览器 @Chrome" entry (file org-agenda-file-links)
              "* TODO [#C] %?\n %(x/retrieve-chrome-current-tab-url)\n %i\n %U"
              :empty-lines 1)
              ;; ==================================
              ("d" "日期树 @ Datetree"
               entry (file+olp+datetree org-agenda-file-datetree)
               "* %?"
               :empty-lines 1)
              ;; End of Template
              ("j" "日志 @Journal Note" entry (file (get-journal-file-today))
               "* %?\n\n  %i\n\n  From: %a" :empty-lines 1)
              ("t" "加载任务 @Task Entry" entry (file+function org-agenda-file-todo x/load-org-tasks)
               "* %?\n\n  %i\n\n  From: %a" :empty-lines 1)
              ("w" "网站 @Website Announcement" entry
               (file+function org-agenda-file-note x/first-header)
               "* %?
              :PROPERTIES:
              :PUBDATE: %t
              :END:
              ,#+HTML: <div class=\"date\">%<%e %b %Y></div>

              %i

              [[%F][Read more...]" :empty-lines 1)
          ))

          ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
          ;; Agenda custom commands 
          ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


          (setq org-agenda-custom-commands
                '(
                  ("w" . "任务安排")
                  ("w1" "工作" tags-todo "work"
                   ((org-agenda-sorting-strategy '(todo-state-down priority-down)))
                   )
                  ("w2" "办公室" tags-todo "@office")
                  ("w3" "自己" tags-todo "self")
                  ("w4" "孩子" tags-todo "daniel")
                  ("w5" "妻子" tags-todo "lulu")
                  ("w6" "家庭" tags-todo "home")
                  ("W" "回顾"
                   (
                    (tags "PROJECT"
                          ((org-agenda-sorting-strategy '(priority-up))))
                    ))
                  ))

          ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
          ;; Org publish
          ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
          (defvar x-website-html-preamble
            "<div class='nav'>
              <ul>
              <li><a href='http://xingwenju.com'>博客</a></li>
              <li><a href='/index.html'>Wiki目录</a></li>
              </ul>
              </div>")

          (defvar x-website-html-blog-head
            " <link rel='stylesheet' href='css/site.css' type='text/css'/> \n
              <link rel=\"stylesheet\" type=\"text/css\" href=\"/css/worg.css\"/>")

          (setq org-publish-project-alist
                `(
                  ("blog-notes"
                   :base-directory "~/Dropbox/org/"
                   :base-extension "org"
                   :publishing-directory "~/Dropbox/shared/public/"

                   :recursive t
                   :html-head , x-website-html-blog-head
                   :publishing-function org-html-publish-to-html
                   :headline-levels 4       ; Just the default for this project.
                   :auto-preamble t
                   :exclude "gtd.org"
                   :exclude-tags ("ol" "noexport")
                   :section-numbers nil
                   :html-preamble ,x-website-html-preamble
                   :author "xingwenju"
                   :email "xingwenju@gmail.com"
                   :auto-sitemap t          ; Generate sitemap.org automagically...
                   :sitemap-filename "index.org" ; ... call it sitemap.org (it's the default)...
                   :sitemap-title "我的wiki"     ; ... with title 'Sitemap'.
                   :sitemap-sort-files anti-chronologically
                   :sitemap-file-entry-format "%t" ; %d to output date, we don't need date here
                   )
                  ("blog-static"
                   :base-directory "~/Dropbox/org/"
                   :base-extension "css\\|js\\|png\\|jpg\\|gif\\|pdf\\|mp3\\|ogg\\|swf"
                   :publishing-directory "~/Dropbox/shared/public/"
                   :recursive t
                   :publishing-function org-publish-attachment
                   )
                  ("blog" :components ("blog-notes" "blog-static"))))

          ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
          ;; miscellaneous configurations
          ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
          (setq org-use-speed-commands t
                org-return-follows-link t
                org-hide-emphasis-markers t
                org-completion-use-ido t
                org-outline-path-complete-in-steps nil
                org-src-fontify-natively t   ;; Pretty code blocks
                org-src-tab-acts-natively t
                org-confirm-babel-evaluate nil ;; No code evaluation confirm
                )

          (setq org-structure-template-alist
                (quote (("s" "#+begin_src ?\n\n#+end_src" "<src lang=\"?\">\n\n</src>")
                        ("e" "#+begin_example\n?\n#+end_example" "<example>\n?\n</example>")
                        ("q" "#+begin_quote\n?\n#+end_quote" "<quote>\n?\n</quote>")
                        ("v" "#+begin_verse\n?\n#+end_verse" "<verse>\n?\n</verse>")
                        ("c" "#+begin_center\n?\n#+end_center" "<center>\n?\n</center>")
                        ("l" "#+begin_latex\n?\n#+end_latex" "<literal style=\"latex\">\n?\n</literal>")
                        ("L" "#+latex: " "<literal style=\"latex\">?</literal>")
                        ("h" "#+begin_html\n?\n#+end_html" "<literal style=\"html\">\n?\n</literal>")
                        ("H" "#+html: " "<literal style=\"html\">?</literal>")
                        ("a" "#+begin_ascii\n?\n#+end_ascii")
                        ("A" "#+ascii: ")
                        ("i" "#+index: ?" "#+index: ?")
                        ("I" "#+include %file ?" "<include file=%file markup=\"?\">"))))

          (setq org-list-demote-modify-bullet (quote (("+" . "-")
                                                      ("*" . "-")
                                                      ("1." . "-")
                                                      ("1)" . "-")
                                                      ("A)" . "-")
                                                      ("B)" . "-")
                                                      ("a)" . "-")
                                                      ("b)" . "-")
                                                      ("A." . "-")
                                                      ("B." . "-")
                                                      ("a." . "-")
                                                      ("b." . "-"))))

          (setq org-time-stamp-rounding-minutes (quote (1 1)))

          (setq org-agenda-clock-consistency-checks
                (quote (:max-duration "4:00"
                        :min-duration 0
                        :max-gap 0
                        :gap-ok-around ("4:00"))))

          ;; Sometimes I change tasks I'm clocking quickly - this removes clocked tasks with 0:00 duration
          (setq org-clock-out-remove-zero-time-clocks t)

          ;; Agenda clock report parameters
          (setq org-agenda-clockreport-parameter-plist
                (quote (:link t :maxlevel 5 :fileskip0 t :compact t :narrow 80)))

          ; Set default column view headings: Task Effort Clock_Summary
          (setq org-columns-default-format "%80ITEM(Task) %10Effort(Effort){:} %10CLOCKSUM")

          ; global Effort estimate values
          ; global STYLE property values for completion
          (setq org-global-properties (quote (("Effort_ALL" . "0:15 0:30 0:45 1:00 2:00 3:00 4:00 5:00 6:00 0:00")
                                              ("STYLE_ALL" . "habit"))))

          ;; Agenda log mode items to display (closed and state changes by default)
          (setq org-agenda-log-mode-items (quote (closed state)))

          ; Tags with fast selection keys
          (setq org-tag-alist (quote ((:startgroup)
                                      ("@errand" . ?e)
                                      ("@office" . ?o)
                                      ("@home" . ?H)
                                      ("@travel" . ?f)
                                      (:endgroup)
                                      ("WAITING" . ?w)
                                      ("HOLD" . ?h)
                                      ("PERSONAL" . ?P)
                                      ("WORK" . ?W)
                                      ("FARM" . ?F)
                                      ("ORG" . ?O)
                                      ("NORANG" . ?N)
                                      ("crypt" . ?E)
                                      ("NOTE" . ?n)
                                      ("CANCELLED" . ?c)
                                      ("FLAGGED" . ??))))

          ; Allow setting single tags without the menu
          (setq org-fast-tag-selection-single-key (quote expert))

          ; For tag searches ignore tasks with scheduled and deadline dates
          (setq org-agenda-tags-todo-honor-ignore-options t)
          ))
)


(defun xingwenju-writer/post-init-org-journal ()
  (with-eval-after-load 'org-journal
    (progn
      (setq org-journal-dir "~/Dropbox/org/journal/")
      (setq org-journal-date-format "#+TITLE: Journal Entry- %e %b %Y (%A)")
      (setq org-journal-time-format "")
    ))
  )

(defun xingwenju-writer/init-nikola()
  "Start nikola support and load library"
  (use-package nikola
    :ensure t
  )
  )
;;; packages.el ends here

(defun xingwenju-writer/init-org-tree-slide ()
  " A quick way to display an org-mode file is using [[https://github.com/takaxp/org-tree-slide][org-tree-slide]].
  * org-tree-slide-move-next-tree (C->)
  * org-tree-slide-move-previous-tree (C-<)
  * org-tree-slide-content (C-x s c)"
  (use-package org-tree-slide
    :ensure t
    :init
    (setq org-tree-slide-skip-outline-level 4)
    (org-tree-slide-simple-profile))
  )
