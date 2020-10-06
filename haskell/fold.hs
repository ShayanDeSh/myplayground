fold :: b -> (a -> b -> b) -> [a] -> b
fold z f []     = z
fold z f (x:xs) = f x (fold z f xs)

sum' :: [Integer] -> Integer
sum'    = fold 0 (+)

product' :: [Integer] -> Integer
product = fold 1 (*)

length' :: [a] -> Integer
length' = fold 0 (\_ s -> s + 1)
