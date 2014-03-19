(add-to-list 'load-path "--PATH--/kuso.d")

(setq developer-name "--FULLNAME--")
(setq developer-email "--EMAIL--")
(setq kuso-workspace "--WORKSPACE--")

(setq el-get-dir "--PATH--/kuso.d/")
(setq el-get-git-install-url "http://github.com/KusoIDE/el-get.git")

(add-to-list 'load-path "--PATH--/kuso.d/el-get/")

(unless (require 'el-get nil t)
  (with-current-buffer
      (url-retrieve-synchronously
       "https://raw.github.com/KusoIDE/el-get/master/el-get-install.el")
    (let (el-get-master-branch)
      (goto-char (point-max))
      (eval-print-last-sexp))
    )
  )

;; Uncomment this line if you want to debug an error
;; (toggle-debug-on-error)

(setq kuso:el-get-packages
      '(kuso-base
        --PLUGINS--
        )
      )

(el-get 'sync kuso:el-get-packages)
