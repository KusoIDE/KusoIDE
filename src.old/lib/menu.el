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

;; ---------------------------------------------------------------------
;; Variables
;; ---------------------------------------------------------------------
(defvar my-desktop-session-dir
  (concat (getenv "HOME") "/.tmp/sessions/")
  "*Directory to save desktop sessions in")

(defvar my-desktop-session-name-hist nil
  "Desktop session name history")

;; ---------------------------------------------------------------------
;; Functions
;; ---------------------------------------------------------------------
(defun pymenu () "draw python project menu"
  ;; Python submenu
  (define-key global-map [Ctrl-x p p d] 'django-proj)
  (define-key global-map [menu-bar file new-proj pyproj djproj] '("Django project" . django-proj))

  (define-key global-map [Ctrl-x p p g] 'generic-py)
  (define-key global-map [menu-bar file new-proj pyproj pygeneric] '("Generic project" . generic-py))
)

(defun elmenu () "draw elisp project menu"
  ;; Elisp menu
  (define-key global-map [Ctrl-x p e s] 'kuso-plugin)
  (define-key global-map [menu-bar file new-proj elproj splug] '("Kuso plugin" . kuso-plugin))

  (define-key global-map [Ctrl-x p e g] 'elgeneric)
  (define-key global-map [menu-bar file new-proj elproj elgeneric] '("Generic project" . elgeneric))
)

(defun save-session () "wrap the desktop-save"
  (let (path)
    (desktop-save-in-desktop-dir)
    )
)

(defun my-desktop-save (&optional name)
  "Save desktop with a name."
  (interactive)
  (unless name
    (setq name (my-desktop-get-session-name "Save session as: ")))
  (make-directory (concat my-desktop-session-dir name) t)
  (desktop-save (concat my-desktop-session-dir name) t)
  )

(defun my-desktop-read (&optional name)
  "Read desktop with a name."
  (interactive)
  (unless name
    (setq name (my-desktop-get-session-name "Load session: ")))
  (desktop-read (concat my-desktop-session-dir name))
  )

(defun my-desktop-get-session-name (prompt)
  (completing-read prompt (and (file-exists-p my-desktop-session-dir)
                               (directory-files my-desktop-session-dir))
                   nil nil nil my-desktop-session-name-hist)
  )

(defun menu/init-menu () "Initializing Kuso IDE menu"
  ;; New Project Menu
  (interactive)
  (define-key-after global-map [menu-bar file new-proj] (cons "New Project" (make-sparse-keymap "new project")) 'new-file)
  (define-key-after global-map [menu-bar file load-session] '("Load Session" . my-desktop-read) 'new-proj)
  (define-key-after global-map [menu-bar file save-session] '("Save Session" . my-desktop-save) 'load-session)

  (define-key global-map (kbd "<f11>") 'my-desktop-read)
  (define-key global-map (kbd "<f12>") 'my-desktop-save)

  ;; New Project sub menus
  (define-key-after global-map [menu-bar file new-proj cproj] (cons "C/C++" (make-sparse-keymap "c-cpp-proj")))
  (define-key-after global-map [menu-bar file new-proj pyproj] (cons "Python" (make-sparse-keymap "python-proj")) 'cproj)
  (define-key-after global-map [menu-bar file new-proj elproj] (cons "Elisp" (make-sparse-keymap "el-proj")) 'phpproj)
  (define-key-after global-map [menu-bar file new-proj jproj] (cons "Java" (make-sparse-keymap "j-proj")) 'elproj)
  (define-key-after global-map [menu-bar file new-proj jsproj] (cons "JS" (make-sparse-keymap "js-proj")) 'jproj)
  (define-key-after global-map [menu-bar file new-proj phpproj] (cons "PHP" (make-sparse-keymap "php-proj")) 'pyproj)
  (define-key-after global-map [menu-bar help-menu about-kuso] '("About KusoIDE" . about-kuso-f) 'about-emacs)
  (message "Menus Initinalized")
)

(defun menu/destruct-menu ()
  "Remove Kuso provided menu form emacs menus"
  (interactive)
  (global-unset-key [menu-bar file new-proj])
  
  )