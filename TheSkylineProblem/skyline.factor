! Copyright (C) 2010 Your name.
! See http://factorcode.org/license.txt for BSD license.
USING: accessors arrays fry heaps kernel 
       monads sequences splitting.monotonic ;
IN: skyline


TUPLE: building left height right ;

: remove-first! ( x seq -- seq )
  swap [ index ] keep remove-nth! ;


: building-start ( building -- start )
  [ left>> ] [ height>> [ suffix! ] curry ] 
  bi 2array ;


: building-end ( building -- end )
  [ right>> ]
  [ height>> [ remove-first! ] curry ]  
  bi 2array ;


: building>assoc ( b -- a )
   [ building-start ] 
   [ building-end ] bi 2array ;


: buildings>queue ( buildings -- queue ) 
  <min-heap> [ '[ building>assoc _ heap-push-all ] each ] keep ;


: queue>skyline ( q -- s )
    [ heap-empty? not ] 
    V{ 0 } '[ heap-pop _ rot call( s -- s ) supremum 2array ] 
    bi-curry produce 
    [ [ last ] bi@ = ] monotonic-split 
    [ first ] map concat ;



: data ( -- buildings )
  { T{ building f 1 11 5 } T{ building f 2 6 7 } 
    T{ building f 3 13 9 } T{ building f 12 7 16 } 
    T{ building f 14 3 25 } T{ building f 19 18 22 }
    T{ building f 23 13 29 } T{ building f 24 4 28 } } ;


: test ( -- skyline )
  data buildings>queue queue>skyline ;

