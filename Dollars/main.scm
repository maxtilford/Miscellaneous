

(define denominations '(0.05 0.1 0.2 0.5 1 2 5 10 20 50 100))

(define (permutations amount denominations)
  (let ((denomination (car denominations)))
    (cond ((= 0 (modulo denomination amount)) 1)
	  ((< amount denomination)
(<= amount (car denominations))
	
 

