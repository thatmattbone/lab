;;The Little Schemer
;;Chapter 3
;;Cons the Magnificent

;;Takes an atom and list as parameters
;;Returns a new list with the first occurence
;;of item removed.
;;Returns null if the list is null.
;;Returns the original list if item is not in list
(defun rember (item list)
  (cond
   ((null list)())
   ((eql item (first list)) (rest list))
   (t (cons (first list) (rember item (rest list))))))

;;As before but removes all the occurences of item.
(defun rember-all (item list)
  (cond
   ((null list) nil)
   ((eql item (first list)) 
    (rember-all item (rest list)))
   (t 
    (cons (first list) (rember-all item (rest list))))))

(defun firsts (list)
  (cond
   ((null list) '())
   (t (cons (first (first list)) (firsts (rest list))))))


;;Insert the element new to the right of element old in list
;;In the book this is only the first occurence, here this is every occurence
(defun insertR (new old list)
  (cond 
   ((null list) nil)
   ((eql old (first list))
    (cons old (cons new (insertR new old (rest list)))))
   (t (cons (first list) (insertR new old (rest list))))))

;;Same as before but we insert to the left
(defun insertL (new old list)
  (cond 
   ((null list) nil)
   ((eql old (first list))
    (cons new (cons old (insertL new old (rest list)))))
   (t (cons (first list) (insertL new old (rest list))))))

;;page 51
(defun my-subst (new old list)
  (cond 
   ((null list) 
    nil)
   ((eql (first list) old)
    (cons new (my-subst new old (rest list))))
   (t 
    (cons (first list) (my-subst new old (rest list))))))

;;page 81, but bit different
(defun rember* (elem list)
  (cond 
   ((null list) nil)
   ((atom (first list))
    (cond 
     ((eql elem (first list))
      (rember* elem (rest list)))
     (t (cons (first list) (rember* elem (rest list))))))
   (t (cons (rember* elem (first list)) (rember* elem (rest list))))))

;;return the leftmost atom in the s-expression
;;page 88
(defun leftmost (list)
  (cond 
   ((null list) nil)
   ((atom (first list)) (first list))
   (t (leftmost (first list)))))

;;page 22
(defun my-member (item list)
  (cond 
   ((null list) nil)
   ((eql item (first list)) t)
   (t (my-member item (rest list)))))

;;page 111
;;(defun is-set (list))

