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

