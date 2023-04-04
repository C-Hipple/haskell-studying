module HsBlog.Html.Internal where

import Numeric.Natural

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


code_ :: String -> Structure
code_ = Structure . el "pre" . escape

h1_ :: String -> Structure
h1_ title = h_ 1 title

h_ :: Natural -> String -> Structure
h_ level =
  Structure . el ("h" <> show level) . escape

instance Semigroup Structure where
  (<>) c1 c2 = Structure (getStructureString c1 <> getStructureString c2)

instance Monoid Structure where
  mempty = empty_


li_ :: String -> [Structure] -> Structure
li_ tag =
  Structure . el tag . concat . map (el "li" . getStructureString)

ul_ :: [Structure] -> Structure
ul_ = li_ "ul"
  --Structure . el "ul" . concat . map (el "li" . getStructureString)

ol_ :: [Structure] -> Structure
ol_ = li_ "ol"


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

empty_ :: Structure
empty_ = Structure ""

concatStructure :: [Structure] -> Structure
concatStructure list =
  case list of
    [] -> empty_
    (x:xs) -> x <> concatStructure xs
