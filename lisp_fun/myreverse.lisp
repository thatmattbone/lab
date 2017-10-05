(defun my-reverse (lst)
  (if (eql lst nil)
      nil
      (append (my-reverse (rest lst)) (first lst))))