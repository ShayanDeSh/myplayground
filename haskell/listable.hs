{-# LANGUAGE FlexibleInstances #-}

class Listable a where
    toList :: a -> [Int]

instance Listable Int where
    toList x = [x]

instance Listable Bool where
    toList True  = [1]
    toList False = [0]

data Tree a = Empty | Node a (Tree a) (Tree a)

instance Listable (Tree Int) where
    toList Empty = []
    toList (Node x l r) = (toList l) ++ [x] ++ (toList r)
