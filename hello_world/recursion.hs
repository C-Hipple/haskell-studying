-- Good article on cons (:) operator
-- https://stackoverflow.com/a/1817891
my_replicate :: Int -> a -> [a]
my_replicate n val =
  if n <= 0
    then
      []
    else
      val : my_replicate (n - 1) val

slow_my_reverse :: [a] -> [a]
slow_my_reverse [] = []
slow_my_reverse (x:xs) = slow_my_reverse(xs) ++ [x]

better_my_reverse :: [a] -> [a]
better_my_reverse [] = []
better_my_reverse (xs) = last xs : better_my_reverse (init xs)

my_odd :: Int -> Bool
my_odd x =
  if x < 0
    then
      True
    else
      my_odd (x - 2)

-- my_even :: Int -> Bool
-- my_even 0 = True
-- my_even x = 

other_even :: Int -> Bool
other_even n =
  if n == 0
    then
      True
    else
      other_odd (n - 1)

other_odd :: Int -> Bool
other_odd n =
  if n == 0
    then
      False
    else
      other_even (n - 1)


main :: IO ()
main = do
  print $ (my_replicate 4 "abc")
  print $ (my_replicate 1 "a")
  print $ (slow_my_reverse [1, 2, 3])
  print $ (init [4,5,6])
  print $ (better_my_reverse [7, 8, 9])
  print $ (my_odd 5)
  print $ (other_odd 5)
