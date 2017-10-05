(compile-file "euler.lisp")
(load "euler.lisp")

(defun prob5 (n)
  (if (all-zeros? (division-list n))
      n
      (prob5 (+ 10 n))))

(defun all-zeros? (mylist)
  (apply #'= (cons 0 mylist)))

(defun division-list (n)
  (mapcar #'(lambda (x) 
	      (multiple-value-bind (f r) (truncate n x)
		r)) 
	  (range 1 21)))