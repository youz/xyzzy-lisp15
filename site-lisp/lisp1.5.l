

(eval-when (:compile-toplevel :load-toplevel :execute)
  (require "lisp1.5/axioms")
  ;(require "lisp1.5/runtime")
  )

(defpackage :lisp1.5
  (:use :lisp :lisp1.5.axioms)
  (:export #:CAR #:CDR #:CONS #:COND #:EQ #:ATOM #:QUOTE
           #:T #:F #:NIL
           #:LAMBDA #:LABEL
           #:$TOPLEVELS #:$= #:-> #:=>))

(require "lisp1.5/mexpr")

(provide "lisp1.5")
