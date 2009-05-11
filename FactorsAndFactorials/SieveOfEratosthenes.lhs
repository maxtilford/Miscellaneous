
> module SieveOfEratosthenes (primes) where
> import qualified PriorityQueue as PQ

primes from two to infinite

> primes = sieve [2 ..]

Sieve takes a list of integers and filters out non-primes.
It uses a min-priority queue to ascertain the next composite to be filtered
This implementation based on Melissa O'Neill's paper available here:
     http://www.cs.hmc.edu/~oneill/papers/Sieve-JFP.pdf

> sieve :: [Int] -> [Int]
> sieve [] = []
> sieve (x:xs) = x : sieve' xs (insertprime x xs PQ.minPQ)
>     where 
>       insertprime p xs table = PQ.insert (p*p) (map (* p) xs) table
>       sieve' []     table = []
>       sieve' (x:xs) table
>              | nextComposite <= x       = sieve' xs (adjust table)
>              | otherwise                = x : sieve' xs (insertprime x xs table)
>           where 
>             nextComposite = PQ.minKey table
>             adjust table
>                 | n <= x      = adjust (PQ.deleteMinAndInsert n' ns table)
>                 | otherwise = table
>                 where (n, n':ns) = PQ.minKeyValue table



Some experiments with wheels, not currently in use

> wheel2357 = 2:4:2:4:6:2:6:4:2:4:6:6:2:6:4:2:6:4:6:8:4:2:4:2:4:8
>             :6:4:6:2:4:6:2:6:6:4:2:4:6:2:6:4:2:4:2:10:2:10:wheel2357

> spin (x:xs) n = n : spin xs (n + x)

> wheeled = 2 : 3 : 5 : 7 : sieve (spin wheel2357 11)

> primes2 = 2 : sieve [3,5 ..]

