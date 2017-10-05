;;1.3
;;not quite right for equals, but illustrates the combinatorial
;;aspects of this problem
;;LOOK UP?
(define (square-larger a b c)
  (cond ((< a b c) (sum-squares b c))
	((< a c b) (sum-squares b c))
	((< b c a) (sum-squares a c))
	((< b a c) (sum-squares a c))
	((< c a b) (sum-squares a b))
	((< c b a) (sum-squares a b))))

;;1.4
(define (a-plus-abs-b a b)
  ((if (> b 0) + -) a b))
;;if b is greater than zero, add a and b
;;if b is less than or equal to zero, subtract b from a
;;More abstractly, this returns the sum of a and the absolute
;;value of b

;;1.5
;;(define (p) (p)) is an infinite loop
;;if we're using an applicative order language, (p) will be evaluated
;;as a paramter and it will loop forever.  If not, (p) is never evaluated,
;;and the test completes normally


;;examples
(define (square x)  (* x x))
	
(define (sqrt x)
  (sqrt-iter 1.0 x))

(define (sqrt-iter guess x)
  (if (good-enough? guess x)
      guess
      (sqrt-iter (improve guess x) x)))

(define (good-enough? guess x)
  (< (abs (- (square guess) x)) 0.001))

(define (improve guess x)
  (average guess (/ x guess)))

(define (average x y)
  (/ (+ x y) 2))

;;1.3

;;examples

(define (sum term a next b)
  (if (> a b)
      0
      (+ (term a)
	 (sum term (next a) next b))))

(define (inc n) (+ n 1))

(define (cube x) (* x x x))

(define (identity x) x)

(define (sum-cubes a b)
  (sum cube a inc b))

(define (sum-integers a b)
  (sum identity a inc b))

;;1.30
(define (sum-iter term a next b)
  (define (iter a result)
    (if (> a b)
	result
	(iter (next a) (+ (term a) result))))
  (iter a 0))

(define (sum-integers-iter a b)
  (sum-iter  identity a inc b))