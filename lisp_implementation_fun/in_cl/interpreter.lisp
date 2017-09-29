;;This is an implementation of a Scheme interpreter in Common Lisp
;;found in Chapter 22 of Peter Norvig's Paradaigms of Artificial 
;;Intelligence Programming
(defun interp (x &optional env)
  "Interpret and evaluate the expression x in the environment env."
  (cond 
    ((symbolp x) (get-var x env)) ;;if we've got a symbol, look up the value
    ((atom x) x) ;;if we've got a non-symbol atom, (ie. a number) just return it
    ;;((scheme-macro (first x))
    ;; (interp (scheme-macro-expand x) env))
    ((case (first x) ;;otherwise we have a list...switch over the first atom in the list
       (QUOTE (second x))
       ;;begin is like progn in CL.  We evaluate (interpret) everything the passed in list
       ;;of code and return the last value in the resulting list
       (BEGIN (last1 (mapcar #'(lambda (y) (interp y env))
			     (rest x))))
       (SET! (set-var! (second x) (interp (third x) env) env))
       (IF  (if (interp (second x) env)
		(interp (third x) env)
		(interp (fourth x) env)))
       (LAMBDA (let ((parms (second x))
		     (code (maybe-add 'begin (rest2 x))))
		 #'(lambda (&rest args)
		     (interp code (extend-env parms args env)))))
       (t (apply (interp (first x) env)
		 (mapcar #'(lambda (v) (interp v env))
			 (rest x))))))))

(defun set-var! (var val env)
  "Set the provided variable to the specified value in the specified environment.  If
   not defined in the specified environment, set the value in the global environment."
  (if (assoc var env)
      (setf (second (assoc var env)) val)
      (set-global-var! var val))
  val)

(defun get-var (var env)
  "Return the value of the specified variable from the specified environment.  If 
   not defined in the specified environment, return the variable from the global 
   environment."
  (if (assoc var env)
      (second (assoc var env))
      (get-global-var var)))

(defun set-global-var! (var val)
  (setf (get var 'global-val) val))

(defun get-global-var (var)
  (let* ((default "unbound")
	 (val (get var 'global-val default)))
    (if (eq val default)
	(error "Unbound Scheme variable: ~a" var)
	val)))

(defun extend-env (vars vals env)
  "Add multiple variables and values to an environment."
  (nconc (mapcar #'list vars vals) env))

(defparameter *scheme-procs*
  '(+ - * / = < > <= >= cons cdr not append list read member 
    (null? null) (eq? eq) (equal? equal) (eqv? eql)
    (write prin1) (display princ) (newline terpri)))

(defun init-scheme-interp ()
  (mapc #'init-scheme-proc *scheme-procs*)
  (set-global-var! t t)
  (set-global-var! nil nil))

(defun init-scheme-proc (f)
  (if (listp f)
      (set-global-var! (first f) (symbol-function (second f)))
      (set-global-var! f (symbol-function f))))

(defun scheme ()
  "My Scheme REPL."
  (init-scheme-interp)
  (loop (format t "~&==> ")
	(print (interp (read) nil))))

;;macro expansion functions:
(defun scheme-macro (symbol)
  (and (symbolp symbol) (get symbol 'scheme-macro)))

(defmacro def-scheme-macro (name parmlist &body body)
  "Define a Scheme macro."
  `(setf (get ',name 'scheme-macro)
	 #'(lambda ,parmlist .,body)))

(defun scheme-macro-expand (x)
  "Macro-expand thise Scheme expression."
  (if (and (listp x) (scheme-macro (first x)))
      (scheme-macro-expand
       (apply (scheme-macro (first x)) (rest x)))
      x))

;;macros
(def-scheme-macro let (bindings &rest body)
  `((lambda ,(mapcar #'first bindings) . ,body)
    .,(mapcar #'second bindings)))

;;utility functions:
(defun maybe-add (op exps &optional if-nil)
  (cond ((null exps) if-nil)
	((length=1? exps) (first exps))
	(t (cons op exps))))

(defun length=1? (list)
  "Is the length of the specified list one?"
  ;;(and (consp list) (null (cdr list))))
  (if (and (listp list) (eq 1 (length list)))
      t
      nil))

(defun last1 (list) 
  "Return the last item in the list as an atom."
  (first (last list)))

(defun rest2 (list)
  (rest (rest list)))

0