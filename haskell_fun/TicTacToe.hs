import Test.QuickCheck
import System.Random

--data definitions:
data TicTacToe = Board deriving Show
data Piece = Empty | Cross | Nought deriving (Eq, Show)
type Board = [Piece] --length restriction? besides a list?
type Location = (Int, Int)

--An empty board
emptyBoard :: Board
emptyBoard = take 9 (repeat Empty)

putCross :: Location -> Board -> Board
putCross = putPiece Cross 

putNought :: Location -> Board -> Board
putNought = putPiece Nought 

putPiece :: Piece -> Location -> Board -> Board 
putPiece piece location board = 
    setValue index piece board
        where index = location2index location

getPiece :: Location -> Board -> Piece
getPiece location board = 
    board !! index
        where index = location2index location

location2index :: Location -> Int
location2index (x, y) = x*3+y

forWin :: Piece -> Piece -> Piece -> Bool
forWin p1 p2 p3 = (not (p1==Empty)) && (p1==p2) && (p2==p3)

hasWin :: Board -> Bool
hasWin board = checkBoard [((0,0), (0,1), (0,2)), 
                           ((1,0), (1,1), (1,2)),
                           ((2,0), (2,1), (2,2)),
                           ((0,0), (1,0), (2,0)),
                           ((0,1), (1,1), (2,1)),
                           ((0,2), (1,2), (2,2)),

--Return a new list with the item at at the specified index
--replaced by the specified value
setValue :: Int -> a -> [a] -> [a]
setValue index value list = 
    let setValue' ([], x:xs) = value:xs
        setValue' (xs, [])   = xs ++ [value] --bug in here...just append to end of list
        setValue' (xs, y:ys) = xs ++ [value] ++ ys
    in setValue' (splitAt index list)

--Test Functions:
--This doesn't work:
{-testSetValue :: Int -> [Int] -> Bool
testSetValue value list = 
    value == (setValue index value list) !! index
        where
          index = do i<-choose (0, length list - 1)
                     return i
-}




