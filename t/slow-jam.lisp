#|
  This file is a part of slow-jam project.
  Copyright (c) 2012 Stephen A. Goss (steveth45@gmail.com)
|#

(in-package :cl-user)
(defpackage slow-jam-test
  (:use :cl
        :slow-jam
        :cl-test-more))
(in-package :slow-jam-test)

(plan 1)

(is (to-list (lcons 1 nil)) (list 1))

(finalize)
