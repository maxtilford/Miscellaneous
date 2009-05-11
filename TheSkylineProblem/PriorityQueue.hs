

module PriorityQueue(PriorityQueue,
                     emptyQueue,
                     pqInsert,
                     pop,
                     listToPQ,
                     isEmpty)
    where

data PriorityQueue k a = Heap k [a] (PriorityQueue k a) (PriorityQueue k a)
                       | Leaf

emptyQueue :: PriorityQueue k a
emptyQueue = Leaf

isEmpty Leaf = True
isEmpty Heap{} = False

pop :: Ord k => PriorityQueue k a -> Maybe ((k,[a]), PriorityQueue k a)
pop Leaf = Nothing
pop (Heap k vs l r) = Just ((k, vs), merge l r)

pqInsert :: Ord k => (k, a) -> PriorityQueue k a -> PriorityQueue k a
pqInsert = merge . unit

listToPQ :: Ord k => [(k,a)] -> PriorityQueue k a
listToPQ = foldr pqInsert emptyQueue


unit (k,v) = Heap k [v] Leaf Leaf

merge Leaf y = y
merge x Leaf = x

merge x@(Heap k vs l r) y@(Heap k' vs' l' r')
          | k == k'   = Heap k (vs ++ vs') (merge l l') (merge r r')
          | k < k'    = Heap k vs (merge r y) l
          | otherwise = Heap k' vs' l' (merge r' x)
