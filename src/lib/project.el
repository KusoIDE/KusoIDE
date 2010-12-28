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

  ;; Project name
  (setq project-name (read-string "Project Name: "))
  (if (string= project-name "") (error "Project name must not be emty"))
  ;; Shit IDE use unix-project-name for dealing with project OS activity stuffs 
  (setq unix-project-name (downcase (replace-regexp-in-string " " "_" project-name)))
  ;; if specified directory does not exists, shit will make it
  (setq project-path (read-directory-name "Project Path: " nil nil nil unix-project-name))
  (log project-path)
  (if (not (file-exists-p project-path))
    (progn
      (mkdir project-path)
      (log "Project directory created")
      )
    )
  ;; TODO: find a way to ask a multi choices question
  (setq project-license (read-string "Project License: "))
  (if (not (member project-license known-licenses))
      (progn
	(setq project-license nil)
	(setq project-author nil)
	(setq project-home-page nil)
	(setq project-author-email nil)
	(setq project-desc nil)
	)
    (progn
      (setq project-author (read-string "Project Author: "))
      (setq project-author-email (read-string "Project Author Email: "))
      (setq project-home-page (read-string "Home Page: "))
      (setq project-desc (read-string "Description: "))
      )
    )

)



(defun project/render (data)
  "Render the data with known context variables and return rendered daa"
  (setq data (replace-regexp-in-string "::project::" project-name data))
  (setq data (replace-regexp-in-string "::desc::" project-desc data))
  (setq data (replace-regexp-in-string "::author::" project-author data))
  (setq data (replace-regexp-in-string "::email::" project-author-email data))
  (setq data (replace-regexp-in-string "::year::" (format-time-string "%Y") data))
)


(defun insert-license ()
"Return the prepared license string."
  (if project-license
      (let (license-data license-file)
	(setq license-file (concat TEMPLATESPATH (concat "licenses/" (concat project-license ".tmpl"))))
	;; loading template file
	(setq license-data (io/read license-file))
	;; Rendering template
;;	(setq license-data (replace-regexp-in-string "::project::" project-name license-data))
;;	(setq license-data (replace-regexp-in-string "::desc::" project-desc license-data))
;;	(setq license-data (replace-regexp-in-string "::author::" project-author license-data))
;;	(setq license-data (replace-regexp-in-string "::email::" project-author-email license-data))
;;	(setq license-data (replace-regexp-in-string "::year::" (format-time-string "%Y") license-data))
	(setq license-data (project/render license-data))
	(identity license-data)
	)
    (let (license-data)
      (setq license-data "Put you GOD DAMN, FUCKing license here")
      )
    )
)


(defun project/render-template (template)
  "Render the template and return the rendered template string"
  (let (data license-data)
    (setq data (io/read template))
    (setq data (project/render data))
    ;; add the license header
    (setq license-data (insert-license))
    (setq data (replace-regexp-in-string "::license::" license-data data))
    )
)

(defun project/write-dest-file (FILE DATA)
  "Write the rendered DATA to its destenation file in project source tree.
destenation file address created from template FILE name.
 FILE : (string) Address of corresponding template 
 DATA : (string) Rendered data"

  (let (curfile destfile)
    (setq curfile (split-string FILE "/"))
    (nbutlast curfile)
    (setq curfile (replace-regexp-in-string "__project__" unix-project-name curfile)) 
    (setq curfile (replace-regexp-in-string "\.tmpl" "" curfile)) 
    (setq destfile (concat project-path curfile))
    )
)
  