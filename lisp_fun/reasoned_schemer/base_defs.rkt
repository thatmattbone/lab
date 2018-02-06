#lang racket

(require minikanren)

(provide (all-defined-out))
;;;;;;;;;;;;;;;;;
;; common defs ;;
;;;;;;;;;;;;;;;;;

; succeed
(define s (== 1 1))

; fail
(define u (== 1 2))

;; new goal that behaves like car
;; for example:
;;   > (run* (x) (car-o '(a b) x))
;;   '(a)
(define (car-o p a)
  (fresh (d)
         (== (cons a d) p)))

;; new goal that behaves like cdr
;; for example:
;;   > (run* (x) (cdr-o '(a b) x))
;;   '((b))
(define (cdr-o p d)
  (fresh (a)
         (== (cons a d) p)))
  
;; new goal that behaves like cons
;; for example:
;;   > (run* (x) (cons-o 'a '(b c) x))
;;   '((a b c))
(define (cons-o a d p)
  (== (cons a d) p))

;; new goal that behaves like null?
;; for example:
;;   > (run* (x) (null-o x))
;;   '(())
(define (null-o x)
  (== '() x))

;; new goal that behaves like eq?
;; for example:
;;   > (run* (x) (eq-o x 'abc))
;;   '(abc)
(define (eq-o x y)
  (== x y))

;; new goal that behaves like pair?
;; for example:
;;   > (run* (x) (pair-o x))
;;   '((_.0 . _.1))
(define (pair-o p)
  (fresh (a d)
         (cons-o a d p)))

;; new goal that behaves like list?
;; for example:
;;   > (run 2 (x) (list-o `(a b c . ,x)))
;;   '(() (_.0))
(define (list-o l)
  (conde
    ((null-o l))
    ((pair-o l)
     (fresh (d)
            (cdr-o l d)
            (list-o d)))))


;; new goal that behaves like list-of-lists?
;; for example:
;;   > (run 5 (x) (list-of-lists-o x))
;;   '(() (()) ((_.0)) (() ()) ((_.0 _.1)))
;;
;;   > (run 5 (x) (list-of-lists-o `((1 2) ,x)))
;;   '(() (_.0) (_.0 _.1) (_.0 _.1 _.2) (_.0 _.1 _.2 _.3))
(define (list-of-lists-o l)
  (conde
    ((null-o l) s)
    ((fresh (a)
            (car-o l a)
            (list-o a))
     (fresh (d)
            (cdr-o l d)
            (list-of-lists-o d)))))

;; new goal that succeeds with a list length 2 where both items are equal
;; for example:
;;   > (run* (x) (twins `(1 ,x)))
;;   '(1)
(define (twins s)
  (fresh (x y)
         (cons-o x y s)
         (cons-o x '() y)))