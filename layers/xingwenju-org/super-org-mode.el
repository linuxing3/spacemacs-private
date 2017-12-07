(setq org-agenda-custom-commands
      '(
        ("w" . "任务安排")
        ("wa" "重要且紧急的任务" tags-todo "+PRIORITY=\"A\"")
        ("wb" "重要且不紧急的任务" tags-todo "-Weekly-Monthly-Daily+PRIORITY=\"B\"")
        ("wc" "不重要且紧急的任务" tags-todo "+PRIORITY=\"C\"")
        ("h" . "家务安排")
  ("ha" "重要且紧急的任务" tags-todo "home")
 ("ha" "重要且紧急的任务" tags-todo "home+PROJECT")
        ("b" "写作" tags "BLOG")
        ("p" . "项目安排")
        ("pw" tags-todo "dev")
        ("pl" tags-todo "dev+PROJECT")
 ("d" . "孩子安排")
 ("da" "重要且紧急的任务" tags-todo "home+kids+PRIORITY=\"A\"")
 ("da" "重要且紧急的任务" tags-todo "home+kids")
        ("W" "每周回顾"
         ((stuck "") ;; review stuck projects as designated by org-stuck-projects
          (tags "PROJECT") ;; review all projects (assuming you use todo keywords to designate projects)
          ))))
