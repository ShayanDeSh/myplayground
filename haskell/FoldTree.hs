data Tree a = Empty 
            | Node (Tree a) a (Tree a)
    deriving (Show, Eq)

leaf :: a -> Tree a
leaf x = Node Empty x Empty

treeFold :: b -> (b -> a -> b -> b) -> Tree a -> b
treeFold e _ Empty = e
treeFold e f (Node l x r) = f (treeFold e f l) x (treeFold e f r)

treeSum :: Tree Integer -> Integer
treeSum a = treeFold 0 (\l x r -> l + x + r) a
