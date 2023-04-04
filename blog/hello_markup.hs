import Markup

example1 :: Document
example1 =
  [
    Paragraph "Hello, World"
  ]

example2 :: Document
example2 =
  [ Heading 1 "Welcome"
  , Paragraph "to this tutorial about haskell"
  ]

example3 :: Document
example3 =
  [ Paragraph "Remember that multiple lines with no separation are grouped together to a single paragraph but list items remain separate."
  , OrderedList
    ["# Item 1 of a list"
    , "# Item 2 of a list"
    ]
  ]

main =
  putStrLn "compiles"
