(defmacro my-when (condition &rest body)
  `(if ,condition (progn ,@body)))