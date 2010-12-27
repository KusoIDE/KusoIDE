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

;; project.el - Shit providen API for projects

;; Known licenses - Only free softwares license 
;; I do not like users who use non-free licenses
;; TODO: gather a complete list of free software licenses
;; TODO: build a hash variable from licenses
(setq known-licenses '("gpl" "bsd" "cc"))

;; Each project plugin should use this function for initializing a versy 
;; basic New Project environment.
(defun new-project () "New project basic function"
  (setq project-name (read-string "Project Name: "))
  ;; Shit IDE use unix-project-name for dealing with project OS activity stuffs 
  (setq unix-project-name (downcase (replace-regexp-in-string " " "_" project-name)))
  ;; if specified directory does not exists, shit will make it
  (setq project-path (read-directory-name "Project Path: " nil nil nil unix-project-name))
  (if (not (file-exists-p project-path))
    (progn
      (mkdir project-path)
      (log "Project directory created")
      )
    )
  ;; TODO: find a way to ask a multi choices question
  (setq project-license (read-string "Project License: "))
  (if (not (member project-license known-licenses))
      (setq project-license nil)
    )
  (setq project-author (read-string "Project Author: "))
  (setq project-home-page (read-string "Home Page: "))
)