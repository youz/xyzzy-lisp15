(defpackage :lisp15.metalisp-mode
  (:use :lisp :editor))

(in-package :lisp15.metalisp-mode)

(defparameter *metalisp-syntax-table*
  (let ((tbl (make-syntax-table)))
    (copy-syntax-table ed::*lisp-mode-syntax-table* tbl)
    (set-syntax-punctuation tbl #\;)
    (set-syntax-match tbl #\[ #\])
    (set-syntax-start-comment tbl #\#)
    tbl))

(defparameter *metalisp-keyword-list*
  (compile-regexp-keyword-list
   '(("car\\|cdr\\|cons\\|eq\\|atom\\|lambda\\|label" nil (:keyword 0))
     ("T\\|F\\|NIL" nil (:keyword 1))
     ("[]()[]" nil (:color 14)))))

(defun ed::metalisp-mode ()
  (interactive)
  (kill-all-local-variables)
  (make-local-variable 'ed::regexp-keyword-list)
  (make-local-variable 'ed::highlight-keyword)
  (setq ed::mode-name "Meta*Lisp"
	ed::buffer-mode 'ed::metalisp-mode
	ed::regexp-keyword-list *metalisp-keyword-list*
	ed::highlight-keyword t)
  (use-keymap ed::*lisp-mode-map*)
  (use-syntax-table *metalisp-syntax-table*))

(provide "lisp15/metalisp-mode")
