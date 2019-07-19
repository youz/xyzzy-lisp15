;;; -*- mode:lisp; package:lisp1.5.axioms -*-

(defpackage :lisp1.5.axioms
  (:use :lisp)
  (:export #:CAR #:CDR #:CONS #:COND #:EQ #:ATOM #:QUOTE
           #:T #:F #:NIL
           #:$TOPLEVELS #:$= #:-> #:=>))

(in-package :lisp1.5.axioms)

(defvar T 'T)
(defvar F 'F)
(defvar NIL 'NIL)

(defun CAR (x) (if (null (car x)) 'NIL (car x)))
(defun CDR (x) (if (null (cdr x)) 'NIL (cdr x)))
(defun CONS (x y) (cons x (if (eq y 'NIL) nil y)))
(defun ATOM (x) (if (consp x) 'F 'T))
(defun EQ (a b) (if (eq a b) 'T 'F))

(defmacro QUOTE (expr) `(quote ,expr))

(defmacro COND (&body clauses)
  (let* ((c (car clauses))
	 (gtest (gensym "test"))
	 (test (car c))
	 (expr (if (and (eq '=> (cadr c)) (cddr c))
		   `(,(caddr c) ,test)
		 (cadr c))))
    `(let ((,gtest ,test))
       (if (or (eq ,gtest 'NIL) (eq ,gtest 'F))
	   ,(if (null (cdr clauses))
		'NIL
	      `(COND ,@(cdr clauses)))
	 ,expr))))

(defmacro $TOPLEVELS (&body forms)
  `(progn ,@(mapcar #'(lambda (expr)
			(if (and (consp expr) (eq (car expr) '$=))
			    `(defun ,(caadr expr) ,(cdadr expr) ,(caddr expr))
			  expr))
		    forms)))


(provide "lisp1.5/axioms")
