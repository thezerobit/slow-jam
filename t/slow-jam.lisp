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

(plan 9)

(is (to-list (lcons 1 nil)) (list 1))

(is (to-list (lmapcar #'* (list 2 3 4 5) (list 4 5 6 7)))
    (list 8 15 24 35))

(is (to-list (lmapcar #'+ (range) (list 1 2 3)))
    (list 1 3 5))

(is (to-list (lmapcar #'+ (list 1 2 3) (range)))
    (list 1 3 5))

(is (to-list (take 10 (range)))
    (to-list (range 10)))

(is (to-list (drop 5 (take 10 (range))))
    (to-list (range 5 10)))

(is (to-list (filter #'evenp (range 10)))
    (to-list (range 0 10 2)))

(is (to-list (filter #'oddp (range 0 10 2)))
    nil)

(is (to-list (drop 5 (take 20 (range))))
    '(5 6 7 8 9 10 11 12 13 14 15 16 17 18 19))

(finalize)
