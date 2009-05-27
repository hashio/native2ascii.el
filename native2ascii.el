;; -*-mode:lisp-*-

(defgroup native2ascii nil
  "Using native2ascii"
  :group 'java
  :prefix 'string)

(defcustom native2ascii-command-format "native2ascii"
  "native2ascii command"
  :group 'native2ascii
  :type '(choice (const :tag "Default" "native2ascii")
				 (string :tag "String")))

(defcustom ascii2native-command-format "native2ascii -reverse"
  "ascii2native command"
  :group 'native2ascii
  :type '(choice (const :tag "Default" "native2ascii -reverse")
				 (string :tag "String")))

(defun native2ascii (start end)
  (interactive "r")
  (let ((coding-system-for-write 'shift_jis))
	(shell-command-on-region start end native2ascii-command-format nil t)))

(defun ascii2native (start end)
  (interactive "r")
  (let ((coding-system-for-read 'shift_jis))
	(shell-command-on-region start end ascii2native-command-format nil t)))

(defun find-file-hook-ascii2native ()
  (if (string-match "\\.properties\\(\\|_ja\\)$" buffer-file-name)
	  (progn
		(buffer-disable-undo)
		(set-buffer-file-coding-system 'sjis)
		(ascii2native (point-min) (point-max))
		(set-buffer-modified-p nil)
		(buffer-enable-undo))))

(defun before-save-hook-native2ascii ()
  (if (string-match "\\.properties\\(\\|_ja\\)$" buffer-file-name)
	  (if (buffer-modified-p)
		  (save-restriction
			(widen)
			(native2ascii (point-min) (point-max))))))

(defun after-save-hook-native2ascii ()
  (if (string-match "\\.properties\\(\\|_ja\\)$" buffer-file-name)
	  (save-restriction
	    (widen)
		(undo-start)
		(undo-more 1)
		(set-buffer-modified-p nil))))
  
(add-hook 'find-file-hooks 'find-file-hook-ascii2native)
(add-hook 'before-save-hook 'before-save-hook-native2ascii)
(add-hook 'after-save-hook 'after-save-hook-native2ascii)

(provide 'native2ascii)
