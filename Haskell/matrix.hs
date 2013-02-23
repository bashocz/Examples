-- test matrix
testMatrix :: [[Int]]
testMatrix = [[1,2,3,4],[2,3,4,1],[3,4,1,2],[4,1,2,3]]

-- determinant of a matrix
front :: Int -> [b] -> [b]
front x m = if (x >= 0) && not (null m) then take x m else []

rear :: Int -> [b] -> [b]
rear x m = if (x >= 0) && not (null m) then drop x m else []

decreaseElement :: Int -> [b] -> [b]
decreaseElement x m = front (if (x > 0) then x else 0) m ++
             rear (if (x < (length m - 1)) then x + 1 else (length m)) m

decreaseRow :: Int -> [b] -> [b]
decreaseRow x m = decreaseElement x m

decreaseColumn :: Int -> [[b]] -> [[b]]
decreaseColumn x m = [decreaseElement x a | a <- m]

decreaseRowAndCol :: Int -> Int -> [[b]] -> [[b]]
decreaseRowAndCol x y m = decreaseRow x (decreaseColumn y m)

sign :: Int -> Int
sign x = if odd x then -1 else 1

element :: Int -> [Int] -> Int
element x v = if (x >= 0) && (x < length v) && not (null v) then head (rear x v) else 0

determinant :: [[Int]] -> Int
determinant [[]] = 0
determinant [[x]] = x
determinant m = sum [(sign i) * ((element i (head m)) * determinant (decreaseRowAndCol 0 i m)) | i <- [0..(length m) - 1]]
