
module Html
  (
    Html
  , Title
  , Structure
  , html_
  , p_
  , h1_
  , append_
  , render
  , escape
  )
where

newtype Html = Html String
newtype Structure = Structure String

type Title = String

getStructureString :: Structure -> String
getStructureString struct =
  case struct of
    Structure str -> str


render :: Html -> String
render struct =
  case struct of
    Html str -> str

el :: String -> String -> String
el tag content = "<" <> tag <> ">" <> content <> "</" <> tag <> ">"

html_ :: String -> Structure -> Html
html_ title content =
  Html ( el "html"
         ( el "head"
           (el "title" (escape title)) <> el "body" (getStructureString content)
         )
       )
-- partial function
p_ :: String -> Structure
p_ = Structure . el "p" . escape


h1_ :: String -> Structure
h1_ = Structure . el "h1" . escape

append_ :: Structure -> Structure -> Structure
append_ (Structure a) (Structure b) = Structure (a <> b)


escape :: String -> String
escape =
  let
    escape_char c =
      case c of
        '<' -> "&lt;"
        '>' -> "&gt;"
        '&' -> "&amp;"
        '"' -> "&quot;"
        '\'' -> "&#39;"
        _ -> [c]
  in
    concat . map escape_char
