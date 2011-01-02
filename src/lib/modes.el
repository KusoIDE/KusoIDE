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

;; This file will define the most popular modes for ShitIDE

;; ---------------------------------------------------------------------
;; Hooks
;; ---------------------------------------------------------------------
(defvar shit-preinit-mode-hook '()
  "This hook runs before initializing the 'shit-mode' minor mode."
  )

(defvar shit-postinit-mode-hook '()
  "This hook runs after 'shit-mode' minor mode initialized."
  )

(defvar shit-prerm-mode-hook '()
  "This hook runs before deactivating 'shit-mode' minor mode."
  )

(defvar shit-postrm-mode-hook '()
  "This hook runs after 'shit-mode' minor mode deactivated."
  )

;; ---------------------------------------------------------------------
;; Keymaps
;; ---------------------------------------------------------------------
(defvar shit-map (make-sparse-keymap)
 "Default keymap for shit-mode minor mode that hold the global key
binding for shit IDE. each language plugin will have their own minor-mode
and keymap for their actions."
)

;; ---------------------------------------------------------------------
;; Groups
;; ---------------------------------------------------------------------
(defgroup shit-group nil
  "Default values for ShitIDE configuration will are categorized here.")

(defgroup shit-features nil
  "This group contains all the optional components of ShitIDE."
  :group 'shit-group
)

;; ---------------------------------------------------------------------
;; Custom Variables
;; ---------------------------------------------------------------------
(defcustom c-plugin t
  "ShitIDE C programming language plugin."
  :group 'shit-features
  :type 'boolean
  :tag '"C Plugin")

;; ----------------------------------------------------------------------
;; Functions
;; ----------------------------------------------------------------------

;; ----------------------------------------------------------------------
;; Minor Modes
;; ----------------------------------------------------------------------
(define-minor-mode shit-mode
  "Toggle Shit mode.
This mode provide a basic configuration for an IDE."
  :init-value nil
  :lighter " Shit"
  :keymap shit-map
  :global t 
  :group 'shit-group

  (if (not shit-mode)
      ;; shit-mode is not loaded
      (let () 
	;; before initiazing mode
	(run-hooks shit-preinit-mode-hook)
	(menu/init-menu)
	;; after mode was initialized
	(run-hooks shit-postinit-mode-hook)
	)
    ;; shit-mode already loaded
    (let ()
      ;; before deactivating mode
      (run-hooks shit-prerm-mode-hook)

      ;; after deactivating mode
      (run-hooks shit-postrm-mode-hook)
      )
    )
  )


;; TODO: provide a easy way for plugins to define a minor mode