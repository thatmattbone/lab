(asdf:oos 'asdf:load-op :cffi)
   
;;; Nothing special about the "CFFI-USER" package.  We're just
;;; using it as a substitute for your own CL package.
(defpackage :cffi-user
  (:use :common-lisp :cffi))

(in-package :cffi-user)

(define-foreign-library libcurl
  (:unix (:or "libcurl.so.3" "libcurl.so"))
  (t (:default "libcurl")))

(use-foreign-library libcurl)

;;; A CURLcode is the universal error code.  curl/curl.h says
;;; no return code will ever be removed, and new ones will be
;;; added to the end.
(defctype curl-code :int)
   
;;; Initialize libcurl with FLAGS.
(defcfun "curl_global_init" curl-code
  (flags :long))

(defcfun "curl_easy_init" :pointer)

(defcfun "curl_easy_cleanup" :void (easy-handle :pointer))