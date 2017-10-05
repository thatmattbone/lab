(defun my-last (lst)
  (if (null (rest lst))
      lst
      (my-last (rest lst))))