;;(in-package "COMMON-LISP-USER")
;;(defpackage :euler 
;;  (:use :common-lisp)
;;  (:export :range))

(defun range (start end)
        (loop for i from start below end collect i))

(defun integer->digit-list (n)
  (loop for char across (write-to-string n)
       collect (parse-integer (string char))))

(defun integer->digit-list2 (n)
  (defun helper (n accumlist)
    (multiple-value-bind (f r) (truncate n 10)
      (if (= f 0) 
	  (cons r accumlist)
	  (helper f (cons r accumlist)))))
  (helper n '()))