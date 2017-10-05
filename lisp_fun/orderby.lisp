(defun group (mylist)
  (when mylist
    (multiple-value-bind (ilist rlist) 
	(group-helper (list (first mylist)) (rest mylist))
      (cons ilist (group rlist)))))		    

(defun group-helper (ilist mylist)
  (if (eq (first mylist) (first ilist))
      (group-helper (cons (first ilist) ilist) (rest mylist))
      (values ilist mylist)))