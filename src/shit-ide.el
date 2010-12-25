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

(setq shit-mode 0)
(setq DEBUG 1)
(setq ROOTPATH nil)
(setq LIBPATH nil)
(setq PLUGINPATH nil)
(setq TEMPLATESPATH nil)

(defun strip-el-ext (STR) "strinp the lastest elist extension suffix"
  (setq ext (replace-regexp-in-string "\.el$" "" STR))
  (setq ext (replace-regexp-in-string "\.elc$" "" ext))
)

(defun load-dir (path) "Load entire directory"
  (setq load-elc (concat path "*.elc"))
  (setq load-el (concat path "*.el"))
  (setq filelist (file-expand-wildcards load-elc))
  (setq tmp (file-expand-wildcards load-el))
  (setq filelist (append filelist tmp))
  (log (format "%s libraries found" filelist))
  ;; TODO: delete unkown filetypes from filelist 
  (setq filelist (mapcar 'strip-el-ext filelist))
  (mapcar 'load filelist)
)

(defun init-shit () "Inittialize Shit IDE environment"
  (log "initializing SHIT . . .")
  (setq cur-path-list (split-string load-file-name "/"))
  (nbutlast cur-path-list)
  (setq ROOTPATH (concat (mapconcat 'identity cur-path-list "/") "/"))
  (setq PLUGINPATH (concat ROOTPATH "plugins/"))
  (setq TEMPLATESPATH (concat ROOTPATH "templates/"))
  (setq LIBPATH (concat ROOTPATH "lib/"))
  (log (format "Running on %s" ROOTPATH))
  (log (format "lib : %s" LIBPATH))
  (log (format "plugins : %s" PLUGINPATH))
  (log (format "templates : %s" TEMPLATESPATH))
  
)

(defun load-lib (ADDR) "load the shit library on the ADDR path"
  (interactive)
  (let (tmp)
    (setq tmp (concat LIBPATH ADDR))
    (load tmp)
    )
  )


(defun log (ARG) "print a log on message buffer."
  (if (= DEBUG 1) (message "[SHIT] DEBUG >>> %s" ARG))
)


(defun start-shit ()
  "A peace of shit configuration that tune emacs to be an IDE."
  (interactive)
  (if (/= shit-mode 1)
      (progn
	(setq shit-mode 1)
	(log "Starting shit mode . . .")
	(init-shit)
	(load-dir LIBPATH)
	(load-dir PLUGINPATH)
	;;(load-lib "menu.el")
	)
      )
  )

(start-shit)
