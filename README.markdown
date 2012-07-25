# Slow-Jam

A Lazy Sequence library for Common Lisp.

## Usage

```common-lisp

;; LCONS is used to like CONS, but lazy
(setq lazylist (lcons :foo (lcons :bar nil)))

;; HEAD is like CAR for lazy sequences
(head lazylist)
;;--> :foo

;; TAIL is like CDR for lazy sequences
(head (tail lazylist))
;;--> :bar

;; lazy generators and functions like FILTER and RANGE
(filter #'oddp (range 20))
;;--> (1 3 5 7 9 11 13 15 17 19)

;; more lazy functions: TAKE and DROP
(drop 5 (take 20 (range)))
;;--> (5 6 7 8 9 10 11 12 13 14 15 16 17 18 19)

;; The REPL only prints the first 20 elements of a sequence
;; to avoid crashing on infinite sequences
(range)
;;--> (0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 ETC...)

;; LMAPCAR (lazy MAPCAR)
(take 10 (lmapcar #'* (range) (range)))
;;--> (0 1 4 9 16 25 36 49 64 81)

;; Regular lists can be used anywhere lazy lists are used
(lmapcar #'* (range) (list 5 4 3 2 1))
;;--> (0 4 6 6 4)

;; Any type can be adapted by implementing HEAD, TAIL, and EMPTY?
;; methods...

```

## Installation

## Author

* Stephen A. Goss (steveth45@gmail.com)

## Copyright

Copyright (c) 2012 Stephen A. Goss (steveth45@gmail.com)

# License

Licensed under the Modified BSD License.

