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

;; IO library


(defun io/read-buf (FILE)
  "Read the file content of FILE into a buffer and return 
the buffer it self."
  (if (file-readable-p FILE)
      (let (read-buffer)
	(setq read-buffer (find-file FILE))
	)
    (error "Can't read '%s' file.")
    )
  )


(defun io/read (FILE)
  "Read the contents of FILE into a buffer and return the content.
already opend buffer died after reading content."
  (let (buf data)
    (setq buf (io/read-buf FILE))
    (setq data (buffer-string))
    (kill-buffer buf)
    (identity data)
    )
  )

(defun io/write (FILE STRING)
  "Write the STRING into FILE if file was writable."
  (if (file-writable-p FILE)
      (with-temp-buffer 
	(insert STRING)
	(write-region (point-min)
		      (point-max)
		      FILE)
	)
    )
  )
