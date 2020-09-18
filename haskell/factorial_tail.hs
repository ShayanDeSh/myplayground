factorial n = let loop acc n' | n' > 1 = loop (acc * n') (n' - 1)
                              | otherwise = acc
               in loop 1 n

main = print (factorial 5)
