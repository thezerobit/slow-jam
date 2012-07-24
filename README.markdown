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

```

## Installation

## Author

* Stephen A. Goss (steveth45@gmail.com)

## Copyright

Copyright (c) 2012 Stephen A. Goss (steveth45@gmail.com)

# License

Licensed under the Modified BSD License.

