
From Wikipedia : http://en.wikipedia.org/wiki/Factorial#Number_theory

        Adrien-Marie Legendre found that the multiplicity of the prime p 
        occurring in the prime factorization of n! can be expressed 
        exactly as

            summation{i=1}->inf floor( n/p^i ).

        This fact is based on counting the number of factors p of the 
        integers from 1 to n. The number of multiples of p in the 
        numbers 1 to n are given by floor( n/p ); however, this formula 
        counts those numbers with two factors of p only once. Hence 
        another floor( n/p^2) factors of p must be counted too. Similarly 
        for three, four, five factors, to infinity. The sum is finite since 
        pi is less than or equal to n for only finitely many values of i, and 
        the floor function results in 0 when applied to pi > n.



compile with ghc --make Main.lhs

> import SieveOfEratosthenes as Sieve
> import Text.Printf



> primeFactorialFactors :: Int -> [Int]
> primeFactorialFactors n = takeWhile (>0) $ map multiplicity Sieve.primes
>     where 
>       multiplicity p = sum $ takeWhile (>0) [n `div` p^i | i <- [1 ..]]


> formatFactors :: [Int] -> String
> formatFactors [] = ""
> formatFactors fs 
>     | length fs <= 15 = format fs
>     | otherwise       = format firstLine ++ "\n      " ++ formatFactors rest
>     where 
>       format = concatMap (printf "%3d")
>       (firstLine,rest) = splitAt 15 fs



> main :: IO ()
> main = io $ map (process . read) . takeWhile (/="0")
>    where
>      process n = printf "%3d! =%s" n . formatFactors $ primeFactorialFactors n


> io :: ([String] -> [String]) -> IO ()
> io process = interact $ unlines . process . lines



