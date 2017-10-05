(defun element-at (lst n)
  (if (eql n 0)
      (first lst)
    (element-at (rest lst) (decf n))))