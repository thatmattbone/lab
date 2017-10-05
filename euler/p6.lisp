(compile-file "euler.lisp")
(load "euler.lisp")

(defun sum-of-squares (n)
  (apply #'+ (mapcar #'(lambda (x) (* x x)) (range 1 (+ 1 n)))))

(defun square-of-sum (n)
  (let ((x (apply #'+ (range 1 (+ 1 n)))))
    (* x x)))