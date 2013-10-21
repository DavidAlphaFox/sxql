(in-package :cl-user)
(defpackage sxql.statement
  (:use :cl
        :sxql.sql-type)
  (:import-from :sxql.operator
                :find-constructor
                :detect-and-convert))
(in-package :sxql.statement)

(cl-syntax:use-syntax :annot)

(defstruct (select-statement (:include sql-composed-statement (name "SELECT"))
                             (:constructor make-select-statement (&rest children))))

(defstruct (insert-into-statement (:include sql-composed-statement (name "INSERT INTO"))
                                  (:constructor make-insert-into-statement (&rest children))))

(defun find-make-statement (statement-name &optional (package *package*))
  (find-constructor statement-name #.(string :-statement)
                    :package package))

@export
(defun make-statement (statement-name &rest args)
  (apply (find-make-statement statement-name #.*package*)
         (mapcar #'detect-and-convert args)))
