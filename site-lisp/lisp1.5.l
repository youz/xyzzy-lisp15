
(defpackage :lisp1.5
  (:use :lisp)
  (:export :$TOPLEVELS
           :CAR :CDR :CONS :ATOM :QUOTE :EQ :COND :LAMBDA
           :T :F :NIL))

(require "lisp1.5/mexpr")
(require "lisp1.5/axioms")
;(require "lisp1.5/runtime")



(provide "lisp1.5")
