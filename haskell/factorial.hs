x = 5

factorial n = if n > 1
                 then n * factorial (n - 1)
                 else 1

main = print (factorial x)
