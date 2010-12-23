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

(defun init-menu () "Initializing Shit IDE menu"
  (log "Initinalizing Menus . . .")
  (define-key-after global-map [menu-bar file new-proj] (cons "New Project" (make-sparse-keymap "new project")) 'new-file)
  (define-key-after global-map [menu-bar file new-proj cproj] (cons "C/C++" (make-sparse-keymap "c-cpp-proj")))
  (define-key-after global-map [menu-bar file new-proj pyproj] (cons "Python" (make-sparse-keymap "python-proj")) 'cproj)
  (define-key-after global-map [menu-bar file new-proj elproj] (cons "Elisp" (make-sparse-keymap "el-proj")) 'phpproj)
  (define-key-after global-map [menu-bar file new-proj jproj] (cons "Java" (make-sparse-keymap "j-proj")) 'elproj)
  (define-key-after global-map [menu-bar file new-proj jsproj] (cons "JS" (make-sparse-keymap "js-proj")) 'jproj)
  (define-key-after global-map [menu-bar file new-proj phpproj] (cons "PHP" (make-sparse-keymap "php-proj")) 'pyproj)
  
)

(init-menu)