(defparameter d 20)

(defun count-grid (x y)
  ;(format t "~A ~A~%" x y)
  (if (and (eql x d) (eql y d))
      1
      (if (or (> x d) (> y d))
	  0
	  (+ (count-grid (1+ x) y)
	     (count-grid x (1+ y))))))
	  
(memoize:memoize-function 
 'count-grid 
 :key #'(lambda (x) (list (first x) (second x)))
 :test #'equal)
      