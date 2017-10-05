(defun my-but-last (lst)
  (if (eql 2 (list-length lst))
      (first lst)
    (my-but-last (rest lst))))

(defun my-count (lst)
  (if (eql lst nil)
      0
    (+ 1 (my-count (rest lst))))))
