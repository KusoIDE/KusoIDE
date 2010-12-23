;;   Shitty - My personal emacs IDE configuration
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

(defun cmenu () "draw c project menu"
  ;; C/C++ submenus
  (define-key global-map [Ctrl-x p c k ] 'kmodule)
  (define-key global-map [menu-bar file new-proj cproj kmodule] '("Kernel Module" . kmodule))
  
  (define-key global-map [menu-bar file new-proj cproj separator2] '("--"))

  (define-key global-map [Ctrl-x p c n ] 'make-cpp)
  (define-key global-map [menu-bar file new-proj cproj cpp-make] '("Make project (C++)" . make-cpp))
  
  (define-key global-map [Ctrl-x p c m ] 'make-c)
  (define-key global-map [menu-bar file new-proj cproj c-make] '("Make project (C)" . make-c))

  (define-key global-map [menu-bar file new-proj cproj separator1] '("--"))

  (define-key global-map [Ctrl-x p c p ] 'generic-cpp)
  (define-key global-map [menu-bar file new-proj cproj cppgeneric] '("Generic project (C++)" . generic-cpp))


  (define-key global-map [Ctrl-x p c g] 'generic-c)
  (define-key global-map [menu-bar file new-proj cproj cgeneric] '("Generic project (C)" . generic-c))
)


(defun pymenu () "draw python project menu"
  ;; Python submenu
  (define-key global-map [Ctrl-x p p d] 'django-proj)
  (define-key global-map [menu-bar file new-proj pyproj djproj] '("Django project" . django-proj))

  (define-key global-map [Ctrl-x p p g] 'generic-py)
  (define-key global-map [menu-bar file new-proj pyproj pygeneric] '("Generic project" . generic-py))
)

(defun elmenu () "draw elisp project menu"
  ;; Elisp menu
  (define-key global-map [Ctrl-x p e s] 'shit-plugin)
  (define-key global-map [menu-bar file new-proj elproj splug] '("Shit plugin" . shit-plugin))

  (define-key global-map [Ctrl-x p e g] 'elgeneric)
  (define-key global-map [menu-bar file new-proj elproj elgeneric] '("Generic project" . elgeneric))
)


(defun init-menu () "Initializing Shit IDE menu"
  (log "Initinalizing Menus . . .")
  ;; New Project Menu
  (define-key-after global-map [menu-bar file new-proj] (cons "New Project" (make-sparse-keymap "new project")) 'new-file)
  
  ;; New Project sub menus
  (define-key-after global-map [menu-bar file new-proj cproj] (cons "C/C++" (make-sparse-keymap "c-cpp-proj")))
  (define-key-after global-map [menu-bar file new-proj pyproj] (cons "Python" (make-sparse-keymap "python-proj")) 'cproj)
  (define-key-after global-map [menu-bar file new-proj elproj] (cons "Elisp" (make-sparse-keymap "el-proj")) 'phpproj)
  (define-key-after global-map [menu-bar file new-proj jproj] (cons "Java" (make-sparse-keymap "j-proj")) 'elproj)
  (define-key-after global-map [menu-bar file new-proj jsproj] (cons "JS" (make-sparse-keymap "js-proj")) 'jproj)
  (define-key-after global-map [menu-bar file new-proj phpproj] (cons "PHP" (make-sparse-keymap "php-proj")) 'pyproj)
 
  (cmenu)
  (pymenu)
  (elmenu)
)

(init-menu)