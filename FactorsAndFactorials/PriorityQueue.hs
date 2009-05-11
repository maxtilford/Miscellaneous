

module PriorityQueue(PriorityQueue,
                     minPQ,
                     insert,
                     minKey,
                     minKeyValue,
                     deleteMinAndInsert,
                     isEmpty)
    where

data PriorityQueue k a = Heap k a (PriorityQueue k a) (PriorityQueue k a)
                       | Leaf

minPQ :: PriorityQueue k a
minPQ = Leaf

isEmpty Leaf = True
isEmpty Heap{} = False

minKey :: PriorityQueue k a -> k
minKey (Heap k _ _ _) = k

minKeyValue :: PriorityQueue k a -> (k,a)
minKeyValue (Heap k v _ _) = (k, v)

deleteMinAndInsert :: Ord k => k -> a -> PriorityQueue k a -> PriorityQueue k a
deleteMinAndInsert k v Leaf = unit k v
deleteMinAndInsert k v (Heap _ _ l r) = merge (insert k v l) r

insert :: Ord k => k -> a -> PriorityQueue k a -> PriorityQueue k a
insert k v = merge $ unit k v


unit k v = Heap k v Leaf Leaf

merge Leaf y = y
merge x Leaf = x
merge x@(Heap k v l r) y@(Heap k' v' l' r')
          | k <= k'    = Heap k v (merge r y) l
          | otherwise = Heap k' v' l' (merge r' x)
