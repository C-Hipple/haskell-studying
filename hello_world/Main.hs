import System.Directory.Internal.Prelude (getArgs)
--import Html (html_)

main :: IO ()
main = do
  args <- getArgs
  case args of
    [x] -> putStrLn $ "Just One argument: " <> (head args)
    [x, y] -> putStrLn (foldMap id args)
    _ -> putStrLn "No Args"
