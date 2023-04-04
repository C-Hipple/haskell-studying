module HsBlog 
  ( main
  , process
  )
  where

import System.Directory (doesFileExist)
import System.Environment (getArgs)

import qualified HsBlog.Markup as Markup
import qualified HsBlog.Html as Html

import HsBlog.Convert (convert)


process :: Html.Title -> String -> String
process title =
  -- Html.render (convert title (Markup.parse_lines Nothing (lines body)))
  Html.render . convert title . Markup.parse

-- handle1Arg :: String -> IO ()
-- handle1Arg input_file = do
--   contents <- readFile input_file
--   putStrLn ( process "No Title" contents )


-- yeah, I see why they implemented the "do" notation
handle1Arg :: String -> IO ()
handle1Arg input_file = do
  contents <- processFile input_file
  putStrLn contents

-- processFile :: String -> String
-- processFile input =
--   readFile input_file >>= \contents ->
--   putStrLn (process "No Title" contents)

processFile :: String -> IO String
processFile input_file = do
  contents <- readFile input_file
  return $ process "No Title" contents

handleNoArgs :: IO ()
handleNoArgs = do
  content <- getContents
  putStrLn (process "Empty Title" content)


handle2Args :: String -> String -> IO ()
handle2Args input_file output_file = do
  putStrLn $ input_file <> output_file
  exists <- doesFileExist output_file
  contents <- processFile input_file
  if exists
    then
    do
      whenIO confirmOverwrite (writeFile output_file contents)
      putStrLn "File exists!"
    else putStrLn "No"

whenIO :: IO Bool -> IO () -> IO ()
whenIO cond action = do
  result <- cond
  if result
    then action
    else pure ()

confirmOverwrite :: IO Bool
confirmOverwrite = do
  putStrLn "Are you sure you want to overwrite file? (y/n)"
  res <- getLine
  case res of
    "y" -> pure True
    "n" -> pure False
    _ -> pure False

main :: IO ()
main = do
  args <- getArgs
  case args of
    [input_file] -> handle1Arg input_file
    --[input_file, output_file] -> translateFile input_file output_file
    [input_file, output_file] -> handle2Args input_file output_file
    [] -> handleNoArgs
    _ -> putStrLn "Error.  Please call with 0, 1, or 2 arguments"
