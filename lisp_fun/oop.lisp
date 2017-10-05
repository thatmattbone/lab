(defmacro define-class (class inst-vars class-vars &body methods)
  `(let ,class-vars 
    (mapcar #'ensure-generic-fn ',(mapcar #'first methods))
    (defun ,class ,inst-vars
      #'(lambda (message)
	  (case message
	    ,@(mapcar #'make-clause methods))))))

(defun make-clause (clause)
  `(,(first clause) #'(lambda ,(second clause) .,(rest2 clause))))

(defun ensure-generic-fn (message)
  (unless (generic-fn-p message)
    (let ((fn #'(lambda (object &rest args)
		  (apply (get-method object message) args))))
      (setf (symbol-function message) fn)
      (setf (get message 'generic-fn) fn))))

(defun generic-fn-p (fn-name)
  (and (fboundp fn-name)
       (eq (get fn-name 'generic-fn) (symbol-function fn-name))))

(defun get-method (object message)
  (funcall object message))

(defun send (object message &rest args)
  (apply (get-method object message) args))

(defun rest2 (list) (rest (rest list)))

(define-class account (name &optional (balance 0.00))
  ((interest-rate .06))
  (withdraw (amt) (if (<= amt balance)
	    (decf balance amt)
	    'insufficient-funds))
  (deposit (amt) (incf balance amt))
  (balance () balance)
  (name () name)
  (interest () (incf balance (* interest-rate balance))))

;;(define-class password-account (password acct) ()
;;  (change-password (pass new-pass)
;;		   (if (equal pass password)
;;		       (setf password new-pass)
;;		       'wrong-password))
;; (otherwise (pass &rest args)
;;	     (if (equal pass password)
;;		 (apply message acct args)
;;		 'wrong-password)))  