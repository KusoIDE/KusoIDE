;;   Shit - My personal emacs IDE configuration
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

;; C project plugin for Shit IDE

(defun init-menus () "Draw required menu for C mode"
  (define-key global-map [Ctrl-x p c k ] 'kmodule)
  (define-key global-map [menu-bar file new-proj cproj kmodule] '("Kernel Module" . kmodule))
  
  (define-key global-map [menu-bar file new-proj cproj separator2] '("--"))
  
  (define-key global-map [Ctrl-x p c n ] 'make-cpp)
  (define-key global-map [menu-bar file new-proj cproj cpp-make] '("Make project (C++)" . make-cpp))
  
  (define-key global-map [Ctrl-x p c m ] 'make-c)
  (define-key global-map [menu-bar file new-proj cproj c-make] '("Make project (C)" . make-c))

  (define-key global-map [menu-bar file new-proj cproj separator1] '("--"))

  (define-key global-map (kbd "\C-x n \C-c") 'generic-cpp)
  (define-key global-map [menu-bar file new-proj cproj cppgeneric] '("Generic project (C++)" . generic-cpp))


  (define-key global-map (kbd "\C-x n c") 'generic-c)
  (define-key global-map [menu-bar file new-proj cproj cgeneric] '("Generic project (C)" . generic-c))
  )

;; Thsi function exists because maybe SHIT needs more information
;; about new project in the feature the new-prject function did not
;; cover
(defun c-new-project () "Create a new C/C++ project"
  (new-project)
)


(defun compile ()
  "Run the make command and return the putput"
  (interactive)
  (let (output)
    (setq output (shell-command-to-string "make"))
    (message output)
    )
)


(defun init-key-bindings ()
  "Initialize the required key bindings for C/C++ project."
  (define-key c-mode (kbd "\C-c \C-c") 'compile)
)


(defun generic-c () "Create a generic type C project"
  (interactive)
  (c-new-project)
  (project/copying-license-copy)
  (let (template-file-regexp license-data filelist cur template-data)
    (setq template-file-regexp (concat TEMPLATESPATH "c/generic_c/*.tmpl"))
    (setq filelist (file-expand-wildcards template-file-regexp))
    (while filelist
      (setq cur (pop filelist))
      (setq template-data (project/render-template cur))
      (setq template-data (replace-regexp-in-string "::unixname::" unix-project-name  template-data))
      (setq template-data (replace-regexp-in-string "::UNIXNAME::" unix-project-name  template-data))
      (project/write-dest-file cur template-data)
      )
    )
  (cd project-path)
  (init-key-bindings)
  (find-file (concat unix-project-name ".c"))
)


(init-menus)