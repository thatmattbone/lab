(compile-file "euler.lisp")
(load "euler.lisp")

(defun factorial (n)
  (if (<= n 1)
      1
      (* n (factorial (- n 1)))))

(defun sum-factorial-100 ()
  (apply #'+ (integer->digit-list (factorial 100))))
