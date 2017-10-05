(compile-file "euler.lisp")
(load "euler.lisp")

(defun rec-digit-sum (digit-list)
  "Recursively sum all the digits in a number until you get an answer
   of one digit"
  (if (eq (length digit-list) 1)
      (first digit-list)
      (digit-sum (apply #'+ digit-list))))

(defun digit-sum (n)
  (rec-digit-sum (integer->digit-list n)))

(defun digit-sum-range (start end)
  (loop for i from start below end collect (digit-sum i)))