(defparameter *sexpbase* nil)

;;make macro?
;;make it so we can add arbitrary # of rules with this func
(defun add-to-db (triple)
  (setq *sexpbase* (cons triple *sexpbase*)))

(defun get-subject (triple) (first triple))
(defun get-predicate (triple) (second triple))
(defun get-object (triple) (third triple))

;;refactor these
(defun filter-subject (subject &optional (db *sexpbase*))
  (remove-if-not #'(lambda (x) (eq subject (get-subject x))) db))
(defun filter-object (object &optional (db *sexpbase*))
  (remove-if-not #'(lambda (x) (eq object (get-object x))) db))
(defun filter-predicate (predicate &optional (db *sexpbase*))
  (remove-if-not #'(lambda (x) (eq predicate (get-predicate x))) db))

;;todo lists
(defun create-todo (title &key (contents nil) (priority nil) (due-date nil))
  (let ((id 'todo1))
    `((,id is-a todo)
      (,id has-title ,title)
      (,id has-contents ,contents)
      (,id has-priority ,priority)
      (,id is-due ,due-date))))



