#lang scheme

;;2.1
(define (make-rat n d) 
  (if (< d 0)
      (cons (* -1 n) (* -1 d))
      (cons n d)))

(define (numer x) (car x))

(define (denom x) (cdr x))

(define (print-rat x)
  (newline)
  (display (numer x))
  (display "/")
  (display (denom x)))

;;2.4
(define (cons-2.4 x y)
  (lambda (m) (m x y)))
(define (car-2.4 z)
  (z (lambda (p q) p)))
(define (cdr-2.4 z)
  (z (lambda (p q) q)))

(define (length items)
  (if (null? items)
      0
      (+ 1 (length (cdr items)))))

(define (length-iter items)
  (define (length-iter-inner items count)
    (if (null? items)
	count
	(length-iter-inner (cdr items) (+ 1 count))))
  (length-iter-inner items 0))

(define (my-append one two)
  (if (null? one)
      two
      (cons (car one) (my-append (cdr one) two)))) 

;;2.6


;;2.17
(define (last-pair mylist)
  (if (null? (cdr mylist))
      mylist
      (last-pair (cdr mylist))))

;;2.18
(define (my-reverse mylist)
  (if (null? mylist)
      mylist
      (append (reverse (cdr mylist)) (list (car mylist))))) 

(define (test-dot x y . z)
  (print x)
  (print y)
  (print z))