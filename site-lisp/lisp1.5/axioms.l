;;; -*- mode:lisp; package:lisp1.5.axioms -*-

(eval-when (:compile-toplevel :load-toplevel :execute)
  (unless (find-package :lisp1.5)
    (require "lisp1.5")))

(defpackage :lisp1.5.axioms
  (:use :lisp :lisp1.5))

(in-package :lisp1.5.axioms)

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
	 (expr (if (and (eq 'lisp1.5::=> (cadr c)) (cddr c))
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
			(if (and (consp expr) (eq (car expr) 'lisp1.5::$=))
			    `(defun ,(caadr expr) ,(cdadr expr) ,(caddr expr))
			  expr))
		    forms)))


(provide "lisp1.5/axioms")
