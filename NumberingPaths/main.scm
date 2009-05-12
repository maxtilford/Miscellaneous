#!/usr/bin/csi -s

(use srfi-1)

;;; quick and dirty implementation just to get the feel for the problem
;;; not efficient in any sense of the word

(define adjacency-list '((1 2 4)
			 ()
			 (4 3)
			 (1)
			 (3)))
(define intersections '(0 1 2 3 4))

(define (num-paths adjacency start finish #!optional (visited '()))
  (cond ((and (member start visited)
	      (member finish visited)) +inf) ;;; We're in a loooop
	
	((and (not (null? visited))            ;;; We're not where we started,
	      (= start finish)) 1)             ;;; and we are where we want to be
	
	(else 
	 (if (null? (list-ref adjacency start)) 0 ;;; No place left to go
	     (fold + 0                         ;;; Onward!
		   (map (lambda (next) 
			  (num-paths adjacency next finish (cons start visited))) 
			(list-ref adjacency start)))))))
  

(define (num-paths-matrix adjacency intersections)
  (map (lambda (start) 
	 (map (lambda (finish) 
		(num-paths adjacency start finish))
	      intersections))
       intersections))


(print (num-paths-matrix adjacency-list intersections))
