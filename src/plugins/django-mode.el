;;   Kuso - My personal emacs IDE
;;    Copyright (C) 2010  Sameer Rahmani <lxsameer@gnu.org>
;;
;;    This program is free software: you can redistribute it and/or modify
;;    it under the terms of the GNU General Public License as published by
;;    the Free Software Foundation, either version 3 of the License, or
;;    any later version.
;;
;;    This program is distributed in the hope that it will be useful,
;;    but WITHOUT ANY WARRANTY; without even the implied warranty of
;;    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;;    GNU General Public License for more details.
;;
;;    You should have received a copy of the GNU General Public License
;;    along with this program.  If not, see <http://www.gnu.org/licenses/>.

;; django plugin


;; -------------------------------------------------------------------
;; Variables
;; -------------------------------------------------------------------
;; -------------------------------------------------------------------
;; Hooks
;; -------------------------------------------------------------------
(defvar django-preinit-hook '()
  "This hook runs before initializing the Kuso django-plugin minor mode."
  )

(defvar django-postinit-hook '()
  "This hook runs after Kuso django-plugin minor mode initialized."
  )

(defvar django-prerm--hook '()
  "This hook runs before deactivating Kuso django-plugin minor mode."
  )

(defvar django-postrm-hook '()
  "This hook runs after Kuso django-plugin minor mode deactivated."
  )

;; ---------------------------------------------------------------------
;; Keymaps
;; ---------------------------------------------------------------------
(defvar kuso-django-map (make-sparse-keymap)
 "Default keymap for Kuso django minor mode that hold the global key
binding for Kuso IDE django plugin"
)

;; ---------------------------------------------------------------------
;; Custom Variables
;; ---------------------------------------------------------------------
(defcustom django-plugin t
  "KusoIDE Django programming language plugin."
  :group 'kuso-features
  :type 'boolean
  :tag '"django plugins")

;; ----------------------------------------------------------------------
;; Functions
;; ----------------------------------------------------------------------
(defun init-keymap ()
  "Initialize the keymap for django plugin."
  (define-key kuso-django-map (kbd "\C-x p d") 'django-region)
  (define-key kuso-django-map (kbd "\C-x p f") 'django-buffer)
  )

(defun init-menus ()
  "Initialize menu entry for django plugin."
  (define-key-after global-map [menu-bar edit sep1] '("--") 'paste-from-menu)
  (define-key-after global-map [menu-bar edit djangoreg] '("Django Selected"  . django-region) 'sep1)
  (define-key-after global-map [menu-bar edit djangobuf] '("Django Buffer" . django-buffer) 'djangoreg)

  (define-key-after global-map [menu-bar edit sep2] '("--") 'djangobuf)
  )
  
(defun destruct-menus ()
  "Remove menus from menubar"
    (global-unset-key [menu-bar edit sep1])
    (global-unset-key [menu-bar edit sep2])
    (global-unset-key [menu-bar edit djangoreg])
    (global-unset-key [menu-bar edit djangobuf])
    )

(defun get-region-text () 
  "Retrive the region (selected) text."
  (let (text start end tmp)
    (setq start (region-beginning))
    (setq end (region-end))
    (if (> start end)
	(progn
	  (setq tmp start)
	  (setq start end)
	  (setq end tmp)
	  )
      )
    (setq text (buffer-substring-no-properties start end))
    )
)


(defun django-region ()
  "django the region and return the URL."
  (interactive)
  (let (a b text type title poster)
    (setq text (get-region-text))
    
    
    (setq title (or (buffer-file-name) (buffer-name)))
    ;; TODO: poster should be the name of current developer
    (setq poster "sameer")
    (setq type (or (cdr (assoc major-mode django-support-types)) ""))
    (with-temp-buffer 
      (insert text)
      (shell-command-on-region (point-min) (point-max) (concat "curl -si" " -F 'content=<-'"
					       " -A 'Kuso django plugin'"
					     " -F 'language=" type "'"
					     " -F 'title=" title "'"
					     " -F 'poster=" poster "'"
					     " http://django.com/api/v1/") (buffer-name))
    


      (goto-char (point-min))
      (setq a (search-forward-regexp "^Location: "))
      (setq b (search-forward-regexp "http://django.com/[0-9]+/"))
      (message "Link: %s" (buffer-substring a b))
      (kill-new (buffer-substring a b))
      )
    )
  )


(defun django-buffer ()
  "django the current-buffer content."
  (interactive)
  (let (a b text type title poster)
    
    (setq title (or (buffer-file-name) (buffer-name)))
    ;; TODO: poster should be the name of current developer
    (setq poster "sameer")
    (setq type (or (cdr (assoc major-mode django-support-types)) ""))
    (setq text (buffer-string))
    (with-temp-buffer 
      (insert text)
      (shell-command-on-region (point-min) (point-max) (concat "curl -si" " -F 'content=<-'"
							       " -A 'Kuso django plugin'"
							       " -F 'language=" type "'"
							       " -F 'title=" title "'"
							       " -F 'poster=" poster "'"
							       " http://django.com/api/v1/") (buffer-name))

      (goto-char (point-min))
      (setq a (search-forward-regexp "^Location: "))
      (setq b (search-forward-regexp "http://django.com/[0-9]+/"))
      (message "Link: %s" (buffer-substring a b))
      (kill-new (buffer-substring a b))
      )
    )
)

;; ----------------------------------------------------------------------
;; Minor Modes
;; ----------------------------------------------------------------------
(define-minor-mode kuso-django-mode
  "Toggle Kuso django plugin mode.
This mode provide an easy way to django a buffer or a snippet of text in
http://www.django.com/

By marking a region and C-x p d this plugin django the code and put the url
in killring and also message the url. You can also use C-x p f to django
the current buffer."
  :lighter nil
  :keymap kuso-django-map
  :global t 
  :group 'kuso-group

  (if kuso-django-mode
      ;; kuso-cplugin-mode is not loaded
      (let () 
	;; before initiazing mode
	(run-hooks 'kuso-django-preinit-hook)
	(init-keymap)
	(init-menus)
	(put 'django-region 'menu-enable nil)
	(force-mode-line-update)
	;; after mode was initialized
	(run-hooks 'kuso-django-postinit-hook)
	)
    ;; kuso-mode already loaded
    (let ()
      ;; before deactivating mode
      (run-hooks 'kuso-django-prerm-hook)
      (destruct-menus)
      ;; after deactivating mode
      (run-hooks 'kuso-django-postrm-hook)
      )
    )
  )
