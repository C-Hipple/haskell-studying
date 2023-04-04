-- <> are infix functions which take an argument on each side and return a value


-- html_ content = "<html>" <> content  <> "</html>"
-- body_ content = "<body>" <> content  <> "</body>"
-- head_ content = "<head>" <> content  <> "</head>"

-- title_ :: String -> String
-- title_ content = "<title>" <> content  <> "</title>"


-- makeHtml :: String -> String -> String
-- makeHtml title content = html_ (head_ (title_ title) <> body_ content)


-- LEsson 3.2 on function arguments & type signatures
el :: String -> String -> String
el tag content = "<" <> tag <> ">" <> content <> "</" <> tag <> ">"

-- partial functions, since el needs another String to compile
html_ :: String -> String
html_ = el "html"

head_ :: String -> String
head_ = el "head"

title_ :: String -> String
title_ = el "title"

body_ :: String -> String
body_ = el "body"


p_ :: String -> String
p_ = el "p"

h1_ :: String -> String
h1_ = el "h1"

makeHtml :: String -> String -> String
makeHtml title content = html_ (head_ (title_ title) <> body_ content)

myHtml :: String
myHtml = makeHtml "hello title" ( h1_ "my page title" <> p_ "my page content")
main =
  putStrLn myHtml


-- Lesson 3.4 on safer HTML construction
newtype Html = Html String
newtype Structure = Structure String

getStructureString :: Structure -> String
getStructureString struct =
  case struct of
    Structure str -> str

bp_ :: String -> Structure
bp_ = Structure . el "p"


append_ :: Structure -> Structure -> Structure
append_ (Structure a) (Structure b) = Structure (a <> b)


render :: Html -> String
render html =
  case html of
    Html str -> str

-- . is called "compose" which is used for chaining functions.  it "takes" 3 args, 2 functions and a value.  In this case, it's taking 

-- . pipes the output from the right side into the left, just like | in bash
