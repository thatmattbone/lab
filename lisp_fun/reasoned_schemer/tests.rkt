#lang racket

(require minikanren)
(require "base_defs.rkt")

;;;;;;;;;;;;;;
;; examples ;;
;;;;;;;;;;;;;;

(define (olive-oil*)
  (run* (x)
        (conde
         ((== 'olive x))
         ((== 'oil x)))))


(define (olive-oil n)
  (run n (x)
        (conde
         ((== 'olive x))
         ((== 'oil x)))))


;;;;;;;;;;;
;; tests ;;
;;;;;;;;;;;
