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

(define (naive-recursive-fib n)
  (if (<= n 1) n
      (+ (naive-recursive-fib (- n 1)) 
	 (naive-recursive-fib (- n 2)))))

(define (tail-recursive-fib n x y)
    (if (= 0 n) y
	(tail-recursive-fib (- n 1) (+ x y) x)))

(let ((n (read)))

  (print (fib-by-rounding n))
  (print (tail-recursive-fib n 1 0))
  (print (naive-recursive-fib n)))
