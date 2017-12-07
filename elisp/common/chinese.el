;; UI and Fonts
(cond
 ;; if windows
 ((string-equal system-type "windows-nt")
  (message "windows system")
  (setq ispell-program-name "aspell")
  (message ispell-program-name)
  (setq w32-pass-alt-to-system nil)
  (setq w32-apps-modifier 'super)
  (dolist (charset '(kana han symbol cjk-misc bopomofo))
      (set-fontset-font (frame-parameter nil 'font)
		      charset
		      (font-spec :family "Microsoft Yahei" :size 14))))

 ;; if linux
 ((string-equal system-type "gnu/linux")
  (message "linux system")
  (set-face-attribute
   'default nil :font "Source Code Pro 16")
  (add-to-list 'default-frame-alist
	    '(font . "DejaVu Sans Mono-16"))
  )
 ;; if mac os
 ((string-equal system-type "darwin")
  (message "Mac os system")
  (set-face-attribute
   'default nil :font "Source Code Pro 16")
  (add-to-list 'default-frame-alist
	    '(font . "Source Code Pro-16"))
  )
 )
