data UsefulPerson
  = UsefulPerson
  { name :: String
  , age  :: Int
  }

data Person
  = Person String Int


getAge :: Person -> Int
getAge (Person _ age ) = age

main = do
  let chris = UsefulPerson "Chris" 32
  let dale = Person "Dale" 45
  print $ age chris
  print $ getAge dale
