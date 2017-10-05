(defun test-+ ()
   (check 
    (= (+ 1 2) 3)
    (= (+ 1 1) 4)
    (= (+ 1 2 3) 6)))

(defun report-result (result form)
  (format t "~:[FAIL~;pass~] ... ~a~%" result form)
  result)

(defmacro check (&body forms)
  `(combine-results
     ,@(loop for f in forms collect `(report-result ,f ',f))))

;;want a macro called combine-results, that executes each
;;and performs an and without short circuiting
(defmacro combine-results (&body forms)
  ;;(with-gensyms (result)
    `(let ((result t))
       ,@(loop for f in forms collect `(unless ,f (setf result nil)))
       result));)