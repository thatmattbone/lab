fibs :: [Integer] 
fibs = 0 : 1 : [ a + b | (a, b) <- zip fibs (tail fibs)]

[x|x <- take 100 fibs, (x<1000000) && (x `mod` 2==0)]
