
zip', zip'' :: [a] -> [b] -> [(a, b)]
zip' a b = [(x, y) | x <- a, y <- b]

zip'' [] _ = []
zip'' _ [] = []
zip'' (x:xs) (y:ys) = (x, y):zip'' xs ys

main = print $ zip'' [1, 2 ,4] [1, 4, 5]
