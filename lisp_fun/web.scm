#lang web-server/insta

(define (zed) (print "this is zed"))

(define (start request)
  '(html (head (title "My Blog"))
         (body (h1 "under construction"))))

(define (test)
  (print "this is a test"))