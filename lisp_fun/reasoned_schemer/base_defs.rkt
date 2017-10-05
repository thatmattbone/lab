#lang racket

(require minikanren)

;;;;;;;;;;;;;;;;;
;; common defs ;;
;;;;;;;;;;;;;;;;;

; succeed
(define s (== 1 1))

; fail
(define u (== 1 2))

(define (car-o p a)
  (fresh (d)
         (== (cons a d) p)))
;; example using car-o:
;;   > (run* (x) (car-o '(a b) x))
;;   '(a)

(define (cdr-o p d)
  (fresh (a)
         (== (cons a d) p)))

(define (cons-o a d p)
  (== (cons a d) p))

;;;;;;;;;;;;;;;;;
;; experiments ;;
;;;;;;;;;;;;;;;;;

(define (olive-oil*)
  (run* (x)
        (conde
         ((== 'olive x) s)
         ((== 'oil x) s))))


(define (olive-oil n)
  (run n (x)
        (conde
         ((== 'olive x) s)
         ((== 'oil x) s))))