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
           :lmapcar))
(in-package :slow-jam)

(defclass lcons ()
  ((head-thunk :initarg :head-thunk)
   (head-forced :initform nil)
   (head)
   (tail-thunk :initarg :tail-thunk)
   (tail-forced :initform nil)
   (tail))

(defmacro lcons (head tail)
  `(make-instance 'lcons
                  :head-thunk (lambda () ,head)
                  :tail-thunk (lambda () ,tail)))

(defgeneric empty? (lcons))
(defgeneric head (lcons))
(defgeneric tail (lcons))

(defmethod empty? ((lcons lcons))
  nil)

(defmethod empty? ((lcons list))
  (null list))

(defmethod head ((lcons lcons))
  (if (slot-value lcons 'head-forced)
    (slot-value lcons 'head)
    (progn
      (setf (slot-value lcons 'head-forced) T)
      (setf (slot-value lcons 'head) (funcall (slot-value lcons 'head-thunk))))))

(defmethod head ((lcons list))
  (car cons))

(defmethod tail ((lcons lcons))
  (if (slot-value lcons 'tail-forced)
    (slot-value lcons 'tail)
    (progn
      (setf (slot-value lcons 'tail-forced) T)
      (setf (slot-value lcons 'tail) (funcall (slot-value lcons 'tail-thunk))))))

(defmethod tail ((lcons list))
  (cdr lcons))

(defun make-range (n)
  (labels ((inner (c) (if (< c n)
                        (lcons c (inner (1+ c)))
                        nil)))
    (inner 0)))

(defun to-list (lcons)
  (let ((newlist '()))
    (loop while (not (null lcons))
          do (progn
               (push (head lcons) newlist)
               (setq lcons (tail lcons))))
    (reverse newlist)))

(defun lmapcar (f &rest lists)
  (if (notany #'empty? lists)
    (let ((heads (mapcar #'head lists))
          (tails (mapcar #'tail lists)))
      (lcons (apply f heads)
             (apply #'lmapcar f tails)))
    nil))

(defun last-val (lcons)
  (let ((head (head lcons))
        (tail (tail lcons)))
    (if tail
      (last-val tail)
      head)))
