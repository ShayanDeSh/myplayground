class Listable a where
    toList :: a -> [Int]

instance Listable Int where
    toList x = [x]

instance Listable Bool where
    toList True  = [1]
    toList False = [0]
