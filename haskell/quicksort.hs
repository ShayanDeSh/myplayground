quicksort :: (Ord a) => [a] -> [a]
quicksort [] = []
quicksort (x:xs) = 
    let smaller_sort = quicksort [a | a <- xs, a < x]
        bigger_sort  = quicksort [a | a <- xs, a >= x]
     in smaller_sort ++ [x] ++ bigger_sort  

main = print $ quicksort [1, -34, 132, -23, 21, 11]
