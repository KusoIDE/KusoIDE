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

(require 'cl)
(require 'comint)
;; -------------------------------------------------------------------
;; Constant
;; -------------------------------------------------------------------
(defconst *python* "/usr/bin/python")

;; -------------------------------------------------------------------
;; Variables
;; -------------------------------------------------------------------
(defvar project-path ""
  "Project source tree path.")

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
(defvar django-map (make-sparse-keymap)
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
(defun django/init-keymap ()
  "Initialize the keymap for django plugin."
  (define-key django-map (kbd "<f6>") 'django-runserver)
  (define-key django-map (kbd "<f7>") 'django-syncdb)
  (define-key django-map (kbd "s-<f1>") 'python/gethelp)
  (define-key django-map (kbd "\C-c s") 'django-shell)
  ;; (define-key django-map (kbd "\C-x p f") 'django-buffer)
  )

(defun django/init-menus ()
  "Initialize menu entry for django plugin."
  (define-key-after global-map [menu-bar django] (cons "Django" (make-sparse-keymap "django-map")))
  (define-key-after global-map [menu-bar django manage] (cons "Management" (make-sparse-keymap "django-manage-map")))
  (define-key-after global-map [menu-bar django manage runserver] '("Development Server"  . django-runserver))
  (define-key-after global-map [menu-bar django manage runserver-extra] '("Development Server Extended"  . django-runserver-extra) 'runserver)
  (define-key-after global-map [menu-bar django manage syncdb] '("Syncdb"  . django-syncdb) 'runserver-extra)
  (define-key-after global-map [menu-bar django manage syncdb-extra] '("Syncdb with extra options"  . django-syncdb-extra) 'syncdb)
  (define-key-after global-map [menu-bar django manage custom-command] '("Custom Command"  . django-command) 'syncdb-extra)
  (define-key-after global-map [menu-bar django shell] '("Project shell"  . django-shell) 'manage)
  (define-key-after global-map [menu-bar django sep2] '("--") 'runserver-extra)
  (define-key-after global-map [menu-bar django pylintcheck] '("Check buffer with pylint"  . pylint-check-current-buffer) 'django-shell)
  (define-key-after global-map [menu-bar django cleanup] '("Cleanup source tree"  . django/cleanup) 'pylintcheck)
  (define-key-after global-map [menu-bar django sep3] '("--") 'cleanup)
  (define-key-after global-map [menu-bar django cwordhelp] '("Current word help"  . python/gethelp) 'sep3)
  )
  
(defun django/destruct-menus ()
  "Remove menus from menubar"
    (global-unset-key [menu-bar django])
    ;; (global-unset-key [menu-bar edit sep2])
    ;; (global-unset-key [menu-bar edit djangoreg])
    ;; (global-unset-key [menu-bar edit djangobuf])
    )

(defun get-project-path ()
  "Get the project path."
  (setq project-path (read-directory-name "Project source tree: "))
)


(defun manage-command (buffername command-process-name command)
  "Run the given command in e new buffer."
    (let (fullcommand lastslash)
    (if (string= project-path "")
	(get-project-path)
      )
    (cd project-path)
    (setq newcommand-buffer (get-buffer-create buffername))
    (ansi-color-for-comint-mode-on)
    (switch-to-buffer newcommand-buffer)
    (add-hook 'after-change-functions 'buffer-change-colorizing t t)
    (setq fullcommand (expand-file-name "manage.py" project-path))
    ;;(setq fullcommand (concat fullcommand " " command))
    (message fullcommand)
    ;;(setq commandp (start-process-shell-command command-process-name newcommand-buffer fullcommand))
    (setq commandp (apply 'make-comint-in-buffer command-process-name newcommand-buffer *python* nil (list fullcommand command)))
    (cd django-cwd)
    )
)

(defun* django-syncdb (&optional (extra ""))
  "Run the django syndb"
  (interactive)
  (let (params)
    (if (not (string= extra ""))
	(setq params (concat "syncdb " extra))
      (setq params "syncdb")
      )
    (manage-command "*Syncdb*" "syncdb" params)
    )
)

(defun django-syncdb-extra ()
  "Run the django syndb with extra options."
  (interactive "sEnter extra options for syncdb: ")
  (django-syncdb extra)
)

(defun buffer-change-colorizing (start end length)
  "colorizing the region from start to end."
  (ansi-color-apply-on-region start end)
)

(defun* django-runserver (&optional (extra ""))
  "Run the project development server in a new buffer"
  (interactive)
  (let (params)
    (if (not (string= extra ""))
	(setq params (concat "runserver " extra))
      (setq params "runserver")
      )
    (manage-command "*Runserver*" "Runserver" params)
    )
  )

(defun django-runserver-extra (args)
  "Run the development server with extra options."
  (interactive "sEnter extra arguments for runserver: ")
  (django-runserver args)
)
(defun django-shell ()
  "Running Django shell."
  (interactive)
  (manage-command "*Shell*" "Shell" "shell")
)

(defun django-command (command)
  "Run the specified command with manage.py"
  (interactive "sEnter command: ")
  (manage-command "*Custom*" "custom" command)
)


(defun django/cleanup ()
  "Remove all the unneecessary files form project."
  (interactive)
  (let (buffer commands)
    (if (string= project-path "")
	(get-project-path)
      )
    (setq commands "rm -fv `find @@pp@@  -iname \"*.pyc\"` && rm -fv `find @@pp@@ -iname \"*~\"` && rm -fv `find @@pp@@ -iname \"\.#*\"` && rm -vf `find @@pp@@ -iname \"#*\"`")
    (setq commands (replace-regexp-in-string "@@pp@@" project-path commands))
    (setq buffer (get-buffer-create "*Cleanup*"))
    (switch-to-buffer buffer)
    (start-process-shell-command "Cleanup" buffer commands)
    )
  
  )

(defun django/get-todo ()
  "Get a list of TODO entries from the project source tree"
  (interactive)
  (let (command gbuffer commandp)
    (if (string= project-path "")
	(get-project-path)
      )
    (setq command (concat "grep \"# TODO:\" " project-path " -Rn -T --color"))
    (message command)
    (setq gbuffer (get-buffer-create "*Grep*"))
    (ansi-color-for-comint-mode-on)
    (switch-to-buffer gbuffer)
    (add-hook 'after-change-functions 'buffer-change-colorizing t t)
    (setq commandp (start-process-shell-command "grep" gbuffer command))

    )
)


(defun pylint-check-current-buffer ()
  "Run pylint on current buffer."
  (interactive)
  (let (cbuffer-file pylint-buffer commandp)
    (setq cbuffer-file (buffer-file-name))
    (if (stringp cbuffer-file)
	(progn
	  (setq pylint-buffer (get-buffer-create "*Pylint*"))
	  (ansi-color-for-comint-mode-on)
	  (switch-to-buffer pylint-buffer)
	  (add-hook 'after-change-functions 'buffer-change-colorizing t t)
	  (setq fullcommand (concat "pylint -f colorized " cbuffer-file))
	  (setq commandp (start-process-shell-command "pylint" pylint-buffer fullcommand))
	  ;;(setq commandp (apply 'make-comint-in-buffer "pylint" pylint-buffer "pylint" nil (list fullcommand)))

	  )
      (message "This buffer did not visit any file.")
      )
    
    )
)

(defun python/gethelp ()
  "Show the python help of current word"
  (interactive)
  (let (cword pybuffer fullcommand)
    (setq pybuffer (get-buffer-create "*PyHelp*"))
    (setq cword (thing-at-point 'word))
    (ansi-color-for-comint-mode-on)
    (switch-to-buffer-other-window pybuffer)
    (erase-buffer)
    (setq fullcommand (concat *python* " -c 'help(\"" cword "\")'"))
    (setq commandp (start-process-shell-command *python* pybuffer fullcommand))
    ;;(setq fullcommand (concat "-c 'help(\"" cword "\")'"))
    ;;(setq commandp (apply 'make-comint-in-buffer "python" pybuffer "python" nil (list fullcommand)))
    )
)
;; ----------------------------------------------------------------------
;; Minor Modes
;; ----------------------------------------------------------------------
(define-minor-mode django-mode
  "Toggle Kuso django plugin mode.
This plugin provide some functionality for speedup django development on
GNUEmacs."
  :lighter nil
  :keymap django-map
  :global t 
  :group 'kuso-group

  (if django-mode
      ;; kuso-cplugin-mode is not loaded
      (let () 
	;; before initiazing mode
	(run-hooks 'django-preinit-hook)
	(django/init-keymap)
	(django/init-menus)
	(setq django-cwd default-directory)
	;;(put 'django-region 'menu-enable nil)
	;;(force-mode-line-update)
	;; after mode was initialized
	(run-hooks 'django-postinit-hook)
	)
    ;; kuso-mode already loaded
    (let ()
      ;; before deactivating mode
      (run-hooks 'django-prerm-hook)
      (django/destruct-menus)
      (setq project-path "")
      ;; after deactivating mode
      (run-hooks 'django-postrm-hook)
      )
    )
  )
(provide 'django)
