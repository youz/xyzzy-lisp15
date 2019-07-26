(defpackage :metalisp-mode
  (:use :lisp :editor))

(in-package :metalisp-mode)

(defparameter *metalisp-syntax-table*
  (let ((tbl (make-syntax-table)))
    (do ((x #x21 (1+ x)))((>= x #x7f))
      (let ((c (code-char x)))
	(unless (alphanumericp c)
	  (set-syntax-punctuation tbl c))))
    (set-syntax-whitespace tbl #\SPC)
    (set-syntax-whitespace tbl #\TAB)
    (set-syntax-whitespace tbl #\RET)
    (set-syntax-match tbl #\( #\))
    (set-syntax-match tbl #\[ #\])
    (set-syntax-start-comment tbl #\#)
    (set-syntax-end-comment tbl #\LFD)
    (set-syntax-symbol tbl #\-)
    (set-syntax-symbol tbl #\=)
    (set-syntax-symbol tbl #\>)
    tbl))

(defparameter *metalisp-keyword-list*
  (compile-regexp-keyword-list
   '(("\\b\\(car\\|cdr\\|cons\\|eq\\|atom\\|lambda\\|label\\)\\b" nil (:keyword 0))
     ("É…" nil (:keyword 0))
     ("->\\|=>\\|Å®\\|ÅÀ" nil (:keyword 1))
     ("\\b\\(T\\|F\\|NIL\\)\\b" nil (:keyword 2))
     ("[]()[]" nil (:color 14))
     (";" nil (:color 15))
     ("\\b[A-Z0-9]+\\b" nil :string)
     )))

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
(export '(ed::metalisp-mode) :ed)

(provide "lisp1.5/metalisp-mode")
