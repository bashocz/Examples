-- triming polynomial
trimPolynomial :: [Int] -> [Int]
trimPolynomial p = if null p then [] else if (last p) /= 0 then p else trimPolynomial (init p)

-- degree of polynomial
polynomialDegree :: [Int] -> Int
polynomialDegree p = length (trimPolynomial p) - 1

-- basic polynomial functions - add, sub
term :: [Int] -> Int -> Int
term p i = if i < (length p) then p!!i else 0
   
addition :: [Int] -> [Int] -> [Int]
addition p1 p2 = trimPolynomial [(term p1 i) + (term p2 i) | i <- [0..(max (length p1) (length p2)) - 1]]
   
subtraction :: [Int] -> [Int] -> [Int]
subtraction p1 p2 = trimPolynomial [(term p1 i) - (term p2 i) | i <- [0..(max (length p1) (length p2)) - 1]]

-- polynomial first derivative
derivative :: [Int] -> [Int]
derivative p = trimPolynomial [(i * (p!!i)) | i <- [1..(length (trimPolynomial p)) - 1]]

derivativeByX :: [Int] -> Int -> [Int]
derivativeByX p 0 = p
derivativeByX p n = derivative (derivativeByX p (n - 1))

-- printing of polynomial
showTerm :: Int -> Int -> String
showTerm 0 i = ""
showTerm a 0 = (if (a > 0) then " + " else " - ") ++ show (abs a)
showTerm a 1 = showTerm a 0 ++ "x"
showTerm a i = showTerm a 0 ++ "x^" ++ show i

showLast :: [Int] -> String
showLast p = if null p then "" else showTerm (last p) ((length p) - 1)

showPolynomial :: [Int] -> String
showPolynomial p = showLast (trimPolynomial p) ++ if null p then "" else showPolynomial (init (if null (trimPolynomial p) then [0] else (trimPolynomial p)))

-- test polynomials
testPolynomial1 :: [Int]
testPolynomial1 = [-3, 2, 0, 4, 10, 0, 0] -- -3 + 2x + 4x^3 + 10x^4
testPolynomial2 :: [Int]
testPolynomial2 = [1, 0, 0, -3, 2, -8] -- 1 - 3x^3 + 2x^4 - 8x^5