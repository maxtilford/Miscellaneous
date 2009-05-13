#!/usr/bin/csi -s

(define phi (/ (+ 1 (sqrt 5)) 2))

(define (fib n) 
  (round (/ (- (expt phi n) 
	       (expt (- 1 phi) n)) 
	    (sqrt 5))))

(print (fib (read)))


