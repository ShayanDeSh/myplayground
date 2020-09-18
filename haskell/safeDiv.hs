safeDiv x y =
    let q = div x y
     in if y == 0 then 0 else q
main = print (safeDiv 1 0)

