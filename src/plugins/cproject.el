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

  (define-key global-map [Ctrl-x p c p ] 'generic-cpp)
  (define-key global-map [menu-bar file new-proj cproj cppgeneric] '("Generic project (C++)" . generic-cpp))


  (define-key global-map [Ctrl-x p c g] 'generic-c)
  (define-key global-map [menu-bar file new-proj cproj cgeneric] '("Generic project (C)" . generic-c))
  )

(defun c-new-project () "Create a new C/C++ project"
  (new-project)
  (log project-name)
)

(defun generic-c () "Create a generic type C project"
  (c-new-project)
)