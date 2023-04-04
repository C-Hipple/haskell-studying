import Html

main :: IO ()
main =
--  putStrLn (escape "<>")
  putStrLn (render myhtml)
--  putStrLn (getStructureString ul_test)


myhtml :: Html
myhtml =
  html_ "<html>"
    ( h1_ "Heading" <>
        (p_ "Paragraph #1" <>
        p_ "Paragraph #2")
    )

-- ul_test :: Structure
-- ul_test =
--   ul_
--     [ p_ "item 1"
--     , p_ "item 2"
--     , p_ "item 3"
--     ]
