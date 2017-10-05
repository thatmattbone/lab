;; This probably isn't the fastest way to do this.
(defun my-reverse (lst)
  (if (eql lst nil)
      lst
    (append (my-reverse (rest lst)) (list (first lst)))))