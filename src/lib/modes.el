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

;; This file will define the most popular modes for KusoIDE

;; ---------------------------------------------------------------------
;; Hooks
;; ---------------------------------------------------------------------
(defvar kuso-preinit-mode-hook '()
  "This hook runs before initializing the 'kuso-mode' minor mode."
  )

(defvar kuso-postinit-mode-hook '()
  "This hook runs after 'kuso-mode' minor mode initialized."
  )

(defvar kuso-prerm-mode-hook '()
  "This hook runs before deactivating 'kuso-mode' minor mode."
  )

(defvar kuso-postrm-mode-hook '()
  "This hook runs after 'kuso-mode' minor mode deactivated."
  )

(defvar kuso-plugin-preinit-hook '()
  "This hook runs before initializing the plugins of Kuso IDE"
  )

(defvar kuso-plugin-init-hook '()
  "This hook allow plugins to initialize them self in Kuso IDE."
  )

(defvar kuso-plugin-postinit-hook '()
  "This hook runs after initializing the plugins of Kuso IDE"
  )

;; ---------------------------------------------------------------------
;; Keymaps
;; ---------------------------------------------------------------------
(defvar kuso-map (make-sparse-keymap)
 "Default keymap for kuso-mode minor mode that hold the global key
binding for Kuso IDE. each language plugin will have their own minor-mode
and keymap for their actions."
)

(defvar kuso-prefix-map (make-sparse-keymap)
  "Make s-c as the default prefix for Kuso IDE minor mode. 
By this prefix all the plugins that have small amount of keybindings
can define their key bindings easily."
)

;; ---------------------------------------------------------------------
;; Groups
;; ---------------------------------------------------------------------
(defgroup kuso-ide nil
  "Default values for KusoIDE configuration will are categorized here."
  :group 'emacs
)

(defgroup kuso-features nil
  "This group contains all the optional components of KusoIDE."
  :group 'kuso-ide
)


;; ----------------------------------------------------------------------
;; Functions
;; ----------------------------------------------------------------------

;; ----------------------------------------------------------------------
;; Minor Modes
;; ----------------------------------------------------------------------
(define-minor-mode kuso-mode
  "Toggle Kuso mode.
This mode provide a basic configuration for an IDE."
  :lighter " Kuso"
  :keymap kuso-map
  :global t 
  :group 'kuso-group

  (if kuso-mode
      ;; kuso-mode is not loaded
      (let () 
	;; before initiazing mode
	(run-hooks 'kuso-preinit-mode-hook)

	;; i really found toolbar and scrollbar useless so i disabled them
	(if tool-bar-mode (tool-bar-mode))
	(if scroll-bar-mode (scroll-bar-mode))
	(menu/init-menu)
	
	(define-key kuso-map (kbd "\S-c") 'kuso-prefix-map)
	(run-hooks 'kuso-plugin-preinit-hook)
	(run-hooks 'kuso-plugin-init-hook)
	(run-hooks 'kuso-plugin-postinit-hook)
	;; after mode was initialized
	(run-hooks 'kuso-postinit-mode-hook)
	)
    ;; kuso-mode already loaded
    (let ()
      ;; before deactivating mode
      (run-hooks 'kuso-prerm-mode-hook)

      ;; return everything to normal
      (if (not tool-bar-mode) (tool-bar-mode))
      (if (not scroll-bar-mode) (scroll-bar-mode))
      (menu/destruct-menu)
      ;; after deactivating mode
      (run-hooks 'kuso-postrm-mode-hook)
      )
    )
  )


;; TODO: provide a easy way for plugins to define a minor mode