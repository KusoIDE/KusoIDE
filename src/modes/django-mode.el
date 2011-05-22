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

;; django plugin


;; -------------------------------------------------------------------
;; Variables
;; -------------------------------------------------------------------
;; -------------------------------------------------------------------
;; Hooks
;; -------------------------------------------------------------------
(defvar django-preinit-hook '()
  "This hook runs before initializing the Kuso django-plugin minor mode."
  )

(defvar django-postinit-hook '()
  "This hook runs after Kuso django-plugin minor mode initialized."
  )

(defvar django-prerm--hook '()
  "This hook runs before deactivating Kuso django-plugin minor mode."
  )

(defvar django-postrm-hook '()
  "This hook runs after Kuso django-plugin minor mode deactivated."
  )

;; ---------------------------------------------------------------------
;; Keymaps
;; ---------------------------------------------------------------------
(defvar django-map (make-sparse-keymap)
 "Default keymap for Kuso django minor mode that hold the global key
binding for Kuso IDE django plugin"
)

;; ---------------------------------------------------------------------
;; Custom Variables
;; ---------------------------------------------------------------------
(defcustom django-plugin t
  "KusoIDE Django programming language plugin."
  :group 'kuso-features
  :type 'boolean
  :tag '"django plugins")

;; ----------------------------------------------------------------------
;; Functions
;; ----------------------------------------------------------------------
(defun init-keymap ()
  "Initialize the keymap for django plugin."
  ;;(define-key django-map (kbd "\C-x p d") 'django-region)
  ;; (define-key django-map (kbd "\C-x p f") 'django-buffer)
  )

(defun init-menus ()
  "Initialize menu entry for django plugin."
  ;; (define-key-after global-map [menu-bar edit sep1] '("--") 'paste-from-menu)
  ;; (define-key-after global-map [menu-bar edit djangoreg] '("Django Selected"  . django-region) 'sep1)
  ;; (define-key-after global-map [menu-bar edit djangobuf] '("Django Buffer" . django-buffer) 'djangoreg)

  ;; (define-key-after global-map [menu-bar edit sep2] '("--") 'djangobuf)
  )
  
(defun destruct-menus ()
  "Remove menus from menubar"
    ;; (global-unset-key [menu-bar edit sep1])
    ;; (global-unset-key [menu-bar edit sep2])
    ;; (global-unset-key [menu-bar edit djangoreg])
    ;; (global-unset-key [menu-bar edit djangobuf])
    )


;; ----------------------------------------------------------------------
;; Minor Modes
;; ----------------------------------------------------------------------
(define-minor-mode django-mode
  "Toggle Kuso django plugin mode.
This plugin provide some functionality for speedup django development on
GNUEmacs."
  :lighter nil
  :keymap django-map
  :global t 
  :group 'kuso-group

  (if django-mode
      ;; kuso-cplugin-mode is not loaded
      (let () 
	;; before initiazing mode
	(run-hooks 'django-preinit-hook)
	(init-keymap)
	(init-menus)
	;;(put 'django-region 'menu-enable nil)
	;;(force-mode-line-update)
	;; after mode was initialized
	(run-hooks 'django-postinit-hook)
	)
    ;; kuso-mode already loaded
    (let ()
      ;; before deactivating mode
      (run-hooks 'django-prerm-hook)
      (destruct-menus)
      ;; after deactivating mode
      (run-hooks 'django-postrm-hook)
      )
    )
  )
