;;MP3 database example from Practical Common Lisp
(defvar *db* nil)

(defun add-record (cd) 
  (push cd *db*))

(defun make-cd (title artist rating ripped)
  (list :title title :artist artist :rating rating :ripped ripped))

(defun dump-d ()
  (dolist (cd *db*)
    (format t "~{~a:~10t~a~%~}~%" cd)))

;;Only to section "Improving the User Interaction"