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

;; new goal that behaves like null
;; for example:
;;   > (run* (x) (null-o x))
;;   '(())
(define (null-o x)
  (== '() x))

;; new goal that behaves like eq
;; for example:
;;   > (run* (x) (eq-o x 'abc))
;;   '(abc)
(define (eq-o x y)
  (== x y))

;; new goal that behaves like pair
;; for example:
;;   > (run* (x) (pair-o x))
;;   '((_.0 . _.1))
(define (pair-o p)
  (fresh (a d)
         (cons-o a d p)))
