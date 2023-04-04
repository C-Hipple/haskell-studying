import Data.Typeable

-- would not belive I just spent like 20 minutes debugging types when the fix was int -> integer smh
doubleItem :: Integer -> Integer
doubleItem = (2*)

doubleMe :: [Integer] -> [Integer]
doubleMe = map doubleItem

main = do
  let xs = [10, 20, 30]
  print $ doubleMe xs
  print $ doubleItem 12
