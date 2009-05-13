#!/usr/bin/csi -s

(define phi (/ (+ 1 (sqrt 5)) 2))

(define (closed-form n) 
  (/ (- (expt phi n) 
	       (expt (- 1 phi) n)) 
	    (sqrt 5)))

(define (fib-by-rounding n)
  (floor (+ (/ (expt phi n) 
	       (sqrt 5)) 
	    (/ 1 2))))

(print (fib-by-rounding (read)))


