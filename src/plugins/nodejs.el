;;   nodejs-mode - NodeJs plugin for KusoIDE
;;    Copyright (C) 2010-2011  Sameer Rahmani <lxsameer@gnu.org>
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

;; lxdjango plugin

(require 'cl)
(require 'comint)
;; -------------------------------------------------------------------
;; Constant
;; -------------------------------------------------------------------
(defconst *node* "node")

;; -------------------------------------------------------------------
;; Variables
;; -------------------------------------------------------------------
(defvar project-path ""
  "Project source tree path.")

;; -------------------------------------------------------------------
;; Hooks
;; -------------------------------------------------------------------
(defvar nodejs-preinit-hook '()
  "This hook runs before initializing the nodejs minor mode."
  )

(defvar nodejs-postinit-hook '()
  "This hook runs after nodejs minor mode initialized."
  )

(defvar nodejs-prerm--hook '()
  "This hook runs before deactivating nodejs minor mode."
  )

(defvar nodejs-postrm-hook '()
  "This hook runs after nodejs minor mode deactivated."
  )

;; ---------------------------------------------------------------------
;; Keymaps
;; ---------------------------------------------------------------------
(defvar nodejs-map (make-sparse-keymap)
 "Default keymap for nodejs minor mode"
)

;; ---------------------------------------------------------------------
;; Groups
;; ---------------------------------------------------------------------
(defgroup nodejs nil
  "Nodejs minor mode for Emacs."
  :group 'programming
  :prefix "nodejs")
;; ---------------------------------------------------------------------
;; Custom Variables
;; ---------------------------------------------------------------------
(defcustom nodejs-plugin t
  "Nodejs framework minor mode."
  :group 'nodejs
  :type 'boolean
  :tag '"nodejs plugins")

;; ----------------------------------------------------------------------
;; Functions
;; ----------------------------------------------------------------------
(defun nodejs/init-keymap ()
  "Initialize the keymap for nodejs plugin."
  (define-key nodejs-map (kbd "<f6>") 'nodejs-run)
  (define-key nodejs-map (kbd "<f7>") 'nodejs-npm)
  )

(defun nodejs/init-menus ()
  "Initialize menu entry for nodejs plugin."
  (define-key-after global-map [menu-bar nodejs] (cons "Nodejs" (make-sparse-keymap "nodejs-map")))
  (define-key-after global-map [menu-bar nodejs run] '("Run"  . nodejs-run))
  (define-key-after global-map [menu-bar nodejs npm] '("Install package (npm)"  . nodejs-npm) 'run)
  )
  
(defun nodejs/destruct-menus ()
  "Remove menus from menubar"
    (global-unset-key [menu-bar nodejs])
    )


(defun nodejs-run ()
  "Run current buffer with node"
  (interactive)
    (let (fullcommand command)
      (setq command (buffer-file-name))
      (if (eq command nil)
	  (progn
	    (save-buffer)
	    (setq command (buffer-file-name))
	    )
	)
      (message command)
      (setq newcommand-buffer (get-buffer-create "*NodeJS*"))
      (ansi-color-for-comint-mode-on)
      (switch-to-buffer newcommand-buffer)
      (add-hook 'after-change-functions 'buffer-change-colorizing t t)
      (setq fullcommand *node*)
      (message fullcommand)
      (setq commandp (apply 'make-comint-in-buffer *node* newcommand-buffer *node* nil (list fullcommand command)))
      )
)

(defun nodejs-npm (package)
  "Install a package using npm utility"
  (interactive "sPackage name: ")
  (let (fullcommand command)
    (setq command (concat "install " package))
    (message command)
    (setq newcommand-buffer (get-buffer-create "*npm*"))
    (ansi-color-for-comint-mode-on)
    (switch-to-buffer newcommand-buffer)
    (add-hook 'after-change-functions 'buffer-change-colorizing t t)
    (setq fullcommand "npm")
    (message fullcommand)
    (setq commandp (apply 'make-comint-in-buffer "npm" newcommand-buffer "npm" nil (list fullcommand "install" package)))
    )
)

;; ----------------------------------------------------------------------
;; Minor Modes
;; ----------------------------------------------------------------------
(define-minor-mode nodejs-mode
  "Toggle nodejs minor mode.
This plugin provide some functionality for speedup nodejs development on
GNUEmacs."
  :lighter nil
  :keymap nodejs-map
  :global t 
  :group 'nodejs

  (if nodejs-mode
      ;; nodejs minor mode is not loaded
      (let () 
	;; before initiazing mode
	(run-hooks 'nodejs-preinit-hook)
	(nodejs/init-keymap)
	(nodejs/init-menus)
	(setq nodejs-cwd default-directory)
	;;(put 'nodejs-region 'menu-enable nil)
	;; after mode was initialized
	(run-hooks 'nodejs-postinit-hook)
	)
    ;; nodejs plugin already loaded
    (let ()
      ;; before deactivating mode
      (run-hooks 'nodejs-prerm-hook)
      (nodejs/destruct-menus)
      (setq project-path "")
      ;; after deactivating mode
      (run-hooks 'nodejs-postrm-hook)
      )
    )
  )
(provide 'nodejs)
