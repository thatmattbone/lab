(defun comp (x env val? more?)
  "Compile the expression into a list of instructions."
  (cond
    ((member x '(t nil)) (comp-const x val? more?))
    ((symbolp x) (comp-var x env val? more?))
    ((atom x) (comp-const x val? more?))
    ((scheme-macro (first x)) (comp (scheme-macro-expand x) env val? more?))
    ((case (first x)
       (QUOTE (arg-count x 1)
              (comp-const(second x) val? more?))
       (BEGIN (comp-begin (rest x) env val? more?))
       (SET! (arg-count x 2)
             (assert (symbolp (second x)) (x)
                     "Only symbols can be set! not ~a in ~a"
                     (second x) x)
             (seq (comp (third x) env t t)
                  (gen-set (second x) env)
                  (if (not val?) (gen 'POP))
                  (unless more? (gen 'RETURN))))
       (IF (arg-count x 2 3)
           (comp-if (second x) (third x) (fourth x) env val? more?))
       (LAMBDA (when val?
                 (let ((f (comp-lambda (second x) (rest2 x) env)))
                   (seq (gen 'FN f) (unless more? (gen 'RETURN))))))
       (t (comp-funcall (first x) (rest x) env val? more?))))))

(defun arg-count (form min &optional (max min))
  "Report an error if form has wrong number of args."
  (let ((n-args (length (rest form))))
    (assert (<= min n-args max) (form)
            "Wrong number of arguments for ~a in ~a:
             ~d supplied, ~d~@[ to ~d~] expected"
            (first form) form n-args min (if (/= min max) max))))

(defun comp-begin (exps env val? more?)
  "Compile a sequence of expressions,
  returning hte last one as the value."
  (cond ((null exps) (comp-const nil val? more?)
  