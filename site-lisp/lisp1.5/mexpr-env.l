
#|
usage:
(let ((buf (get-buffer-create "eval.l")))
  (erase-buffer buf)
  (with-output-to-buffer (buf)
    (format t "(in-package :lisp1.5)~%")
    (format t "~A~%" (lisp1.5:mexpr-env "eval.mx" "mapcar.mx"))))
|#


(eval-when (:compile-toplevel :load-toplevel :execute)
  (require "lisp1.5"))

(in-package :lisp1.5)
(export '(mexpr-env))

(defun mexpr-env (&rest buffers)
  (let ((defs nil))
    (dolist (buf buffers)
      (let ((parsed (lisp1.5.mexpr:parse-buffer buf)))
	(unless (and (consp parsed) (eq (car parsed) '$TOPLEVELS))
	  (error "invalid form: ~A" parsed))
	(setq defs (append defs (cdr parsed)))))
    (let ((env (loop for e in defs
		 when (and (consp e) (eq (car e) '$=))
		 collect (list (caadr e) 'LAMBDA (cdadr e) (caddr e)))))
      `($TOPLEVELS
	 ,@defs
	 ($= (EVAL* E) (EVAL E ',env))))))

(provide "lisp1.5/mexpr-env")
