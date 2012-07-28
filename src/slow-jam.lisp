#|
  This file is a part of slow-jam project.
  Copyright (c) 2012 Stephen A. Goss (steveth45@gmail.com)
|#

(in-package :cl-user)
(defpackage slow-jam
  (:use :cl)
  (:export :lcons
           :empty?
           :head
           :tail
           :to-list
           :lmapcar
           :range
           :take
           :drop
           :filter
           :|ETC...|))
(in-package :slow-jam)

(defclass lcons ()
  ((val :initarg :val)))

(defmacro lcons (head tail)
  `(make-instance 'lcons
                  :val (cons ,head (lambda () ,tail))))

(defgeneric empty? (lcons))
(defgeneric head (lcons))
(defgeneric tail (lcons))

(defmethod empty? ((lcons lcons))
  nil)

(defmethod empty? ((lcons list))
  (null lcons))

(defmethod head ((lcons lcons))
  (car (slot-value lcons 'val)))

(defmethod head ((lcons list))
  (car lcons))

(defmethod tail ((lcons lcons))
  (funcall (cdr (slot-value lcons 'val))))

(defmethod tail ((lcons list))
  (cdr lcons))

(defun range (&optional a b c)
  (labels ((inner (start end step)
             (if (or
                   (and (> step 0) (< start end))
                   (and (< step 0) (> start end)))
               (lcons start (inner (+ start step) end step))))
           (infinite (n)
             (lcons n (infinite (1+ n)))))
    (if c
      (inner a b c)
      (if b
        (inner a b 1)
        (if a
          (inner 0 a 1)
          (infinite 0))))))

(defun to-list (lcons &key max)
  (let ((newlist '())
        (items-added 0))
    (loop while (and (not (null lcons))
                     (not (and max (>= items-added max))))
          do (progn
               (incf items-added)
               (push (head lcons) newlist)
               (setq lcons (tail lcons))))
    (values (reverse newlist) (not (empty? lcons)))))

(defmethod print-object ((object lcons) stream)
  (multiple-value-bind (list more) (to-list object :max 20)
    (if more (setq list (append list (list '|ETC...|))))
    (print-object list stream)))

(defun lmapcar (f &rest lists)
  (if (notany #'empty? lists)
    (lcons (apply f (mapcar #'head lists))
           (apply #'lmapcar f (mapcar #'tail lists)))))

(defun last-val (lcons)
  (if (tail lcons)
    (last-val (tail lcons))
    (head lcons)))

(defun take (n lcons)
  (if (and (> n 0) (not (empty? lcons)))
    (lcons (head lcons) (take (1- n) (tail lcons)))))

(defun drop (n lcons)
  (if (> n 0)
    (drop (1- n) (tail lcons))
    lcons))

(defun filter (p lcons)
  (if (not (empty? lcons))
    (let ((val (head lcons)))
      (if (funcall p val)
        (lcons val (filter p (tail lcons)))
        (filter p (tail lcons))))))

(defun lreduce (f lcons)
  (let ((accumulator (head lcons)))
    (setq lcons (tail lcons))
    (loop while (not (empty? lcons))
          do (progn
               (setq accumulator (funcall f accumulator (head lcons)))
               (setq lcons (tail lcons))))
    accumulator))
