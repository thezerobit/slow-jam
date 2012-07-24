#|
  This file is a part of slow-jam project.
  Copyright (c) 2012 Stephen A. Goss (steveth45@gmail.com)
|#

(in-package :cl-user)
(defpackage slow-jam-test-asd
  (:use :cl :asdf))
(in-package :slow-jam-test-asd)

(defsystem slow-jam-test
  :author "Stephen A. Goss"
  :license "Modified BSD License"
  :depends-on (:slow-jam
               :cl-test-more)
  :components ((:module "t"
                :components
                ((:file "slow-jam"))))
  :perform (load-op :after (op c) (asdf:clear-system c)))
