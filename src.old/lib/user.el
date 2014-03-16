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

;; --------------------------------------------------------------------
;; Groups
;; --------------------------------------------------------------------
(defgroup kuso-user-preferences nil
  "User preferences group. this group contain user specified options for
Kuso IDE"
  :group 'kuso-ide
  :tag '"User Preferences"
)

;; --------------------------------------------------------------------
;; Custom Variables
;; --------------------------------------------------------------------
(defcustom developer-name nil
  "KusoIDE use this option as author name in project if the value be non-nil"
  :group 'kuso-user-preferences
  :type 'string
  :tag '"Developer full name"
)

(defcustom developer-email nil
  "KusoIDE use this option as author email in project if the value be non-nil"
  :group 'kuso-user-preferences
  :type 'string
  :tag '"Developer Email"
)

(defcustom kuso-workspace "~/src/"
  "KusoIDE use this option as default path for new project."
  :group 'kuso-user-preferences
  :type 'string
  :tag '"Workspace"
)
