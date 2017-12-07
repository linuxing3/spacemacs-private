;; Using rg for quick research
(global-set-key (kbd "C-s") 'counsel-grep-or-swiper)
 (setq counsel-grep-base-command
   "rg -i -M 120 --no-heading --line-number --color never '%s' %s")


;; Global functions keys
;; (global-set-key (kbd "<f1>") 'view-order-manuals)
(define-key global-map (kbd "<f2>") 'menu-bar-open)
;; (global-set-key (kbd "<f3>") 'kmacro-start-macro-or-insert-counter)
;; (global-set-key (kbd "<f4>") 'kmacro-end-or-call-macro

(global-set-key (kbd "<f5>") 'ibuffer)  ;; Using buffer
;; (global-set-key (kbd "<f6>") 'revert-buffer) ;; Undo some changes
(global-set-key (kbd "<f6>") 'common-map)
(global-set-key (kbd "<f7>") 'toggle-frame-fullscreen)
(global-set-key (kbd "<f8>") 'w3m)  ;; For web browsing

;; x-map
(define-prefix-command 'x-map)
(define-key x-map (kbd "SPC") 'execute-extended-command)
(define-key x-map (kbd "TAB") 'previous-buffer)
(define-key x-map (kbd "f") 'file-map)
(define-key x-map (kbd "o") 'org-map)
(define-key x-map (kbd "j") 'journal-map)
(define-key x-map (kbd "p") 'package-map)
(define-key x-map (kbd "c") 'common-map)
(define-key x-map (kbd "s") 'snippet-map)
(define-key x-map (kbd "t") 'service-map)

;; Quick shortcuts
(define-key x-map (kbd "a") 'org-agenda)
(define-key x-map (kbd "b") 'ibuffer)
(define-key x-map (kbd "d") 'dired)
(define-key x-map (kbd "t") 'counsel-load-theme)
(define-key x-map (kbd "i") 'gtd)
(define-key x-map (kbd "m") 'counsel-bookmark)
(define-key x-map (kbd "s") 'counsel-projectile-rg)
(define-key x-map (kbd "TAB") 'org-global-cycle)
(define-key x-map (kbd "g") 'counsel-rg)
(define-key x-map (kbd "p") 'package-install)
(define-key x-map (kbd "S") 'eshell)
(define-key x-map (kbd "r") 'xingwenju/reload-init)

;; file map
(define-prefix-command 'file-map)
(define-key file-map (kbd "f") 'find-file) ;; open file
(define-key file-map (kbd "j") 'dired)     ;; open directory
(define-key file-map (kbd "b") 'ibuffer)   ;; open buffer
(define-key file-map (kbd "m") 'counsel-bookmark)
(define-key file-map (kbd "s") 'counsel-projectile-rg)
(define-key file-map (kbd "e") (lambda () (interactive) (find-file user-init-file)))
(define-key file-map (kbd "1") 'gtd)
(define-key file-map (kbd "2") 'work)
(define-key file-map (kbd "3") 'kid)
(define-key file-map (kbd "4") 'common-init-file)
(define-key file-map (kbd "5") 'writer-init-file)

;; journal map
(define-prefix-command 'journal-map)
(define-key journal-map (kbd "t") 'journal-file-today) ;; journal file for today
(define-key journal-map (kbd "y") 'journal-file-yesterday) ;; journal file for yesterday
(define-key journal-map (kbd "i") 'journal-file-insert) ;; insert template
(define-key journal-map (kbd "Y") 'journal-file-year) ;; journal file for year

;; package map
(define-prefix-command 'package-map)
(define-key package-map (kbd "l") 'package-list-packages) ;; list packages
(define-key package-map (kbd "L") 'counsel-package) ;; list with counsel
(define-key package-map (kbd "d") 'describe-package) ;; describe package
(define-key package-map (kbd "a") 'load-library) ;; describe package

;; service map
(define-prefix-command 'service-map)
(define-key service-map (kbd "p") 'prodigy) ;;

;; define set of key sequences
(define-prefix-command 'common-map)
(define-key common-map (kbd "RET") 'execute-extended-command)
(define-key common-map (kbd "<menu>") 'exchange-point-and-mark)
(define-key common-map (kbd "'") 'quoted-insert)
(define-key common-map (kbd "2") 'delete-window)
(define-key common-map (kbd "3") 'delete-other-windows)
(define-key common-map (kbd "4") 'split-window-below)
(define-key common-map (kbd "5") 'split-window-right)
(define-key common-map (kbd "7") 'dired-jump)
(define-key common-map (kbd "9") 'ispell-word)
(define-key common-map (kbd "b") 'end-of-buffer)
(define-key common-map (kbd "d") 'beginning-of-buffer)
(define-key common-map (kbd "g") 'isearch-forward)
(define-key common-map (kbd "k") 'yank)
(define-key common-map (kbd "l") 'recenter-top-bottom)
(define-key common-map (kbd "m") 'universal-argument)
(define-key common-map (kbd "p") 'query-replace)
(define-key common-map (kbd "r") 'revert-buffer)
(define-key common-map (kbd "z") 'comment-dwim)

;; snippet map
(define-prefix-command 'snippet-map)
(define-key snippet-map (kbd "1") 'yas-global-mode)
(define-key snippet-map (kbd "i") 'yas-insert-snippet)
(define-key snippet-map (kbd "n") 'yas-new-snippet)
(define-key snippet-map (kbd "f") 'yas-visit-snippet-file)
(define-key snippet-map (kbd "r") 'yas-reload-all)
