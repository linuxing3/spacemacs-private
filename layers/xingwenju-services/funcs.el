;;; funcs.el --- xingwenju-services Layer packages File for Spacemacs
;;
;; Copyright (c) 2015-2016 x 
;;
;; This file is not part of GNU Emacs.
;;
;;; License: GPLv3

(define-minor-mode
  shadowsocks-proxy-mode
  :global t
  :init-value nil
  :lighter " SS"
  (if shadowsocks-proxy-mode
      (setq url-gateway-method 'socks)
    (setq url-gateway-method 'native)))


(define-global-minor-mode
  global-shadowsocks-proxy-mode shadowsocks-proxy-mode shadowsocks-proxy-mode
  :group 'shadowsocks-proxy)

(defmacro adjust-major-mode-keymap-with-evil (m &optional r)
  `(eval-after-load (quote ,(if r r m))
     '(progn
        (evil-make-overriding-map ,(intern (concat m "-mode-map")) 'normal)
        ;; force update evil keymaps after git-timemachine-mode loaded
        (add-hook (quote ,(intern (concat m "-mode-hook"))) #'evil-normalize-keymaps))))

;; http://blog.lojic.com/2009/08/06/send-growl-notifications-from-carbon-emacs-on-osx/
(defun x/growl-notification (title message &optional sticky)
  "Send a Growl notification"
  (do-applescript
   (format "tell application \"GrowlHelperApp\" \n
              notify with name \"Emacs Notification\" title \"%s\" description \"%s\" application name \"Emacs.app\" sticky \"%s\"
              end tell
              "
           title
           message
           (if sticky "yes" "no"))))

(defun x/growl-timer (minutes message)
  "Issue a Growl notification after specified minutes"
  (interactive (list (read-from-minibuffer "Minutes: " "10")
                     (read-from-minibuffer "Message: " "Reminder") ))
  (run-at-time (* (string-to-number minutes) 60)
               nil
               (lambda (minute message)
                 (x/growl-notification "Emacs Reminder" message t))
               minutes
               message))
(defun x/load-my-layout ()
  (interactive)
  (persp-load-state-from-file (concat persp-save-dir "xingwenju")))

(defun x/save-my-layout ()
  (interactive)
  (persp-save-state-to-file (concat persp-save-dir "xingwenju")))


;; My Nicola blog system
(defun x/nikola-new ()
  "Nikola new post with orgmode"
  (interactive)
  (shell-command "cd ~/Dropbox/xingwenju.com/blogs; nikola new_post -t Nikola -f orgmode")
  )

(defun x/nikola-deploy ()
  "Nikola deploy to Github Page"
  (interactive)
  (shell-command "cd ~/Dropbox/xingwenju.com/blogs; nikola github_deploy")
  )

(defun x/nikola-serve ()
  "Nikola serve with local server"
  (interactive)
  (shell-command "cd ~/Dropbox/xingwenju.com/blogs; nikola serve -p 9999 &")
  )

(defun x/nikola-build ()
  "Nikola build new pages"
  (interactive)
  (shell-command "cd ~/Dropbox/xingwenju.com/blogs; nikola build &")
  )

(defun x/crawl-eluniversal-goscript ()
  "Crawl the news"
  (interactive)
  (shell-command "cd ~/go/src/github.com/gocolly/colly/_examples; go run eluniversal/eluniversal.go >> ~/results.json")
  (find-file "~/results.json")
  )

(defun x/scrapy-venezuela-news ()
  "Crawl the news about Venezuela from some popular newspapers"
  (interactive)
  (shell-command "cd ~/Dropbox/shared/InformationCenter && scrapy crawl eluniversal")
  (shell-command "cd ~/Dropbox/shared/InformationCenter && scrapy crawl elnacional")
  (shell-command "cd ~/Dropbox/shared/InformationCenter && scrapy crawl correodelorinoco")
  (shell-command "cd ~/Dropbox/shared/InformationCenter && scrapy crawl ultimanoticias")
  )

(defun x/insert-venezuela-news ()
  "Crawl the news about Venezuela from some popular newspapers"
  (interactive)
  (insert-file "~/Dropbox/shared/InformationCenter/eluniversal_results.txt")
  (insert-file "~/Dropbox/shared/InformationCenter/elnacional_results.txt")
  (insert-file "~/Dropbox/shared/InformationCenter/correodelorinoco_results.txt")
  (insert-file "~/Dropbox/shared/InformationCenter/ultimanoticias_results.txt")
  (mark-whole-buffer)
  (fill-paragraph)
  )
