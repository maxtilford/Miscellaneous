
Compile with ghc --make Main.lhs

This problem could be solved by having a big array, and overlaying
the maximum height on each of the indices. There a couple problems with that.
One is it wouldn't be able to handel decimals, and I don't see any reason
why it shouldn't be able to. 
Another is it would be slow.
More importantly, it wouldn't be much fun.

Instead, I'm using the scanline algorithm.
It requires:
   min-priority queue: see PriorityQueue.hs

   red-black tree: 
      Due to time constraints (homework) and because I'd rather not copy/paste 
      someone else's tree, I'm just using a list. This ruins the asymptotic time, 
      but it works.
      Adapting this implementation to use a Red-Black tree would require changing
      two lines of code.

> import PriorityQueue
> import Data.List


Read a building from stdin in the the format: left top right

> readBuilding = (\(l:h:r:[])-> (l,h,r)) . map read . words

Turn a building into two events, one to insert it's height into the list of 
heights, and one to remove it.
Ideally we'd use a Red Black Tree, in which case the function would be:

buildingTo Events (l,h,r) = [(l, rbinsert h), (r, rbdelete h)]

> buildingToEvents (l,h,r) = [(l, (:) h),(r, delete h)]

Turn a skyline into a string

> showSkyLine s = (unwords $  map showCoordinate s) ++ "\n"
> showCoordinate (x,y) = show x ++ " " ++ show y


Initializes a priority queue of building events and 
a list of heights (optimally wouuld be a Red Black Tree) 
with a base height, for use in building a Skyline.

> newSkyLineState initialHeight buildings = 
>     (listToPQ $ concatMap buildingToEvents buildings, [initialHeight])


Get a skyline state, with the given initial height and event queue.
Unfold the state to a list using step, which returns each 
x-coordinate with it's maximum y-coordinate.
Get rid of unneccessary (x,y) pairs by grouping them on y and keeping the first.

> buildSkyLine initialHeight = map head . groupBy (equalBy snd) 
>                              . unfoldr step . newSkyLineState initialHeight
>     where 
>       step (eventQueue, heights) = 
>           do ((x,events),eventQueue') <- pop eventQueue
>              let heights' = foldr ($) heights events
>              return ((x, maximum heights'), (eventQueue', heights'))


Pass input from stdin, split it into a list of lines
Turn each line into a building, and pass that list to buildSkyLine, which has
an initial height of 0.
Turn the resulting skyline into a string, and print it to stdout.

> main :: IO ()
> main = interact $ showSkyLine . buildSkyLine 0 . map readBuilding . lines 


helper function

> equalBy f x y = (f x) == (f y)