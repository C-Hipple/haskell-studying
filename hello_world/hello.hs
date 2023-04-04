import Html

main :: IO ()
main =
--  putStrLn (escape "<>")
  putStrLn (render myhtml)

myhtml :: Html
myhtml =
  html_ "<html>"
  (
    append_
    ( h1_ "Heading")
    ( append_
      (p_ "Paragraph #1")
      (p_ "Paragraph #2")
    )
  )
