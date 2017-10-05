--Exercise 1
--main :: IO ()
--main = do args <- getArgs
--          putStrLn ("Hello, " ++ args !! 0 ++ " " ++ args !! 1)

--Exercise 2
--main :: IO ()
--main = do args <- getArgs
--          putStrLn ("The double of " ++ args !! 0 ++ " is " ++ show (read (args !! 0)*2))

--Exercise 3
--main :: IO ()
--main = do putStrLn "Type some text: "
--          line <- getLine
--          putStrLn ("You typed: " ++ line)