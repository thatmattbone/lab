(defun my-factorial-recur (x)
  (if (<= x 1)
      1
    (* x (my-factorial (- x 1)))))

(defun my-factorial-iter (x)
  (my-factorial-iter-step 1 1 x))

(defun my-factorial-iter-step (total count end)
  (if (> count end)
      total
    (my-factorial-iter-step (* total count) (+ count 1) end)))