-- data Maybe a
--   = Nothing
--   | Just a


safeHead :: [a] -> Maybe a
safeHead li =
  if length li >= 1
    then Just (head li)
  else Nothing

main = do
  let l = [1, 2, 3]
  print $ safeHead l

  let l2 = [] :: [Int]
  print $ safeHead l2
