factorial n = loop 1 n
    where loop acc n' | n' > 1 = loop (acc * n') (n' - 1)
                      | otherwise = acc

main = print (factorial 5)
