
--Problem 1
--Find last element in list

findLast [x] = x
findLast (_:xs) = findLast xs

--Problem 2
--Find the second to last element in the list
findSecondLast (x:y:[]) = x
findSecondLast (_:xs) = findSecondLast xs

fib :: Int -> Int
fib n = fibGen 0 1 n

fibGen :: Int->Int->Int->Int
fibGen a b n = case n of
                 0 -> a
                 n -> fibGen b (a+b) (n-1)

fibRec :: Int->Int
fibRec n = case n of
          0 -> 0
          1 -> 1
          n -> fibRec (n-1) + fibRec (n-2)