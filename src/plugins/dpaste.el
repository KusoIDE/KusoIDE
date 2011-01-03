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

;; dpaste.com plugin

;; -------------------------------------------------------------------
;; Variables
;; -------------------------------------------------------------------

;; This variable copied from an other dpaste.el at
;; https://github.com/gregnewman/dpaste.el/blob/master/dpaste.el
(defvar dpaste-support-types '((css-mode . "Css")
                                       (diff-mode . "Diff")
                                       (haskell-mode . "Haskell")
                                       (html-mode . "DjangoTemplate")
                                       (javascript-mode . "JScript")
                                       (js2-mode . "JScript")
                                       (python-mode . "Python")
                                       (inferior-python-mode . "PythonConsole")
                                       (ruby-mode . "Ruby")
                                       (sql-mode . "Sql")
                                       (sh-mode . "Bash")
                                       (xml-mode . "Xml")))
;; -------------------------------------------------------------------
;; Hooks
;; -------------------------------------------------------------------
(defvar kuso-dpaste-preinit-hook '()
  "This hook runs before initializing the Kuso dpaste-plugin minor mode."
  )

(defvar kuso-dpaste-postinit-hook '()
  "This hook runs after Kuso dpaste-plugin minor mode initialized."
  )

(defvar kuso-dpaste-prerm--hook '()
  "This hook runs before deactivating Kuso dpaste-plugin minor mode."
  )

(defvar kuso-dpaste-postrm-hook '()
  "This hook runs after Kuso dpaste-plugin minor mode deactivated."
  )

;; ---------------------------------------------------------------------
;; Keymaps
;; ---------------------------------------------------------------------
(defvar kuso-dpaste-map (make-sparse-keymap)
 "Default keymap for Kuso c-plugin minor mode that hold the global key
binding for Kuso IDE dpaste plugin"
)

;; ---------------------------------------------------------------------
;; Custom Variables
;; ---------------------------------------------------------------------
(defcustom dpaste-plugin t
  "KusoIDE C programming language plugin."
  :group 'kuso-features
  :type 'boolean
  :tag '"dpaste.com plugins")

;; ----------------------------------------------------------------------
;; Functions
;; ----------------------------------------------------------------------
(defun init-keymap ()
  "Initialize the keymap for dpaste plugin."
  (define-key kuso-dpaste-map (kbd "\C-x p d") 'dpaste-region)
  (define-key kuso-dpaste-map (kbd "\C-x p f") 'dpaste-buffer)
  )

(defun init-menus ()
  "Initialize menu entry for dpaste plugin."
  (define-key-after global-map [menu-bar edit sep1] '("--") 'paste-from-menu)
  (define-key-after global-map [menu-bar edit dpastereg] '("Dpaste Selected" . dpaste-region) 'sep1)
  (define-key-after global-map [menu-bar edit dpastebuf] '("Dpaste Buffer" . dpaste-buffer) 'dpastereg)

  (define-key-after global-map [menu-bar edit sep2] '("--") 'dpastebuf)
  )
  
(defun destruct-menus ()
  "Remove menus from menubar"
    (global-unset-key [menu-bar edit sep1])
    (global-unset-key [menu-bar edit sep2])
    (global-unset-key [menu-bar edit dpastereg])
    (global-unset-key [menu-bar edit dpastebuf])
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

(defun dpaste-region ()
  "dpaste the region and return the URL."
  (interactive)
  (let (start end text type title run poster command buf)
    (setq start (region-beginning))
    (setq end (region-end))
    (if (> start end)
	(progn
	  (setq tmp start)
	  (setq start end)
	  (setq end tmp)
	  )
      )
    ;;(setq text (get-region-text))
    (deactivate-mark)
    (setq title (or (buffer-file-name) (buffer-name)))
    (setq poster "sameer")
    (setq but (generate-new-buffer "*Paste*"))
    ;; This line of code gets from the el file that i mentioned above
    (setq type (or (cdr (assoc major-mode dpaste-support-types)) ""))
    (shell-command-on-region start end (concat "curl -si" " -F 'content=<-'"
					     " -F 'language=" type "'"
					     " -F 'title=" title "'"
					     " -F 'poster=" poster "'"
					     " http://dpaste.com/api/v1/") buf)
    (with-current-buffer buf
      (message "<><><> %s " buffer-string)
      )
    ;;(setq output (shell-command-to-string command))
    ;;(message ">>> %s" output)
    )
  )
;; ----------------------------------------------------------------------
;; Minor Modes
;; ----------------------------------------------------------------------
(define-minor-mode kuso-dpaste-mode
  "Toggle Kuso dpaste plugin mode.
This mode provide an easy way to dpaste a buffer or a snippet of text in
http://www.dpaste.com/

By marking a region and C-x p d this plugin dpaste the code and put the url
in killring and also message the url. You can also use C-x p f to dpaste
the current buffer."
  :lighter nil
  :keymap kuso-dpaste-map
  :global t 
  :group 'kuso-group

  (if kuso-dpaste-mode
      ;; kuso-cplugin-mode is not loaded
      (let () 
	;; before initiazing mode
	(run-hooks 'kuso-dpaste-preinit-hook)
	(init-keymap)
	(init-menus)
	;; after mode was initialized
	(run-hooks 'kuso-dpaste-postinit-hook)
	)
    ;; kuso-mode already loaded
    (let ()
      ;; before deactivating mode
      (run-hooks 'kuso-dpaste-prerm-hook)
      (destruct-menus)
      ;; after deactivating mode
      (run-hooks 'kuso-dpaste-postrm-hook)
      )
    )
  )
