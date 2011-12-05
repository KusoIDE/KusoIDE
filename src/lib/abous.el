;;   Kuso - My personal emacs IDE
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

(defvar aboutkusoidemsg "
Kuso IDE %%VERSION%% Copyright © 2010-2011 Sameer Rahmani <lxsameer@gnu.org>
Kuso IDE release under the term of GPLv2.

Home page:
\thttp://kuso.lxsameer.com

Credits:
\tSameer Rahmani (lxsameer)
\tBehnam Ahmad Khan Beigi (b3hnam)
\tNima Nazari (niman)

"
  "About Kuso IDE")



(defun about/get_string ()
  "Get the about message string"
  (let (msg)
    (setq msg (replace-regexp-in-string "%%VERSION%%" KUSO-VERSION aboutkusoidemsg)) 
    )
)

(defun about-kuso-f ()
  "Show an small about note"
  (interactive)
  (let (buf msg)
    (setq buf (get-buffer-create "*About Kuso IDE*"))
    (setq msg (about/get_string))
    (set-buffer buf)
    (insert msg)
    (view-buffer buf)
    )
)
