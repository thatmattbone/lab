(ns clojurefun.core)

(defn my-nth [items n]
  (loop [cnt n]))

(defn adder [x] (+ 1 x))

(defn my-nth [items n]
  (loop [current 0 items items]
    (if (= current n)
      (first items)
      (recur (inc current) (rest items)))))

(defn my-count [items]
  (loop  [count 1 items items] 
    (if (= (rest items) '())
      count
      (recur (inc count) (rest items)))))

(defn my-sum [items]
  (loop [total 0 items items]
    (if (= items '[])
      total
      (recur (+ total (first items)) (rest items)))))

(defn hello-world [foo] foo)
      
  