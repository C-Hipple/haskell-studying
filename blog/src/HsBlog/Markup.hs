module HsBlog.Markup
  ( Document
  , Structure(..)
  , parse
  )
  where

import Numeric.Natural
import Data.Maybe (maybeToList)

type Document
  = [Structure]

data Structure
  = Heading Natural String
  | Paragraph String
  | UnorderedList [ String ]
  | OrderedList [ String ]
  | CodeBlock [String]
  deriving (Eq, Show)

-- these are before using the rest of the implemented features
-- first_parse :: String -> Document
-- first_parse = first_parse_lines [] . lines

-- -- This indiscriminately breaks lines into  paragraphs, but we don't remember any context, so they're all <p>
-- -- Below we track a context so we can use our different structure types
-- first_parse_lines :: [String] -> [String] -> Document
-- first_parse_lines current_paragraph txts =
--   let
--     paragraph = Paragraph (unlines (reverse current_paragraph))
--   in
--     case txts of
--       [] -> [paragraph]
--       current_line : rest ->
--         if trim current_line == ""
--           then
--             paragraph : first_parse_lines [] rest
--           else
--             first_parse_lines (current_line : current_paragraph) rest

parse :: String -> Document
parse = parse_lines Nothing . lines

parse_lines :: Maybe Structure -> [String] -> Document
parse_lines context txts =
  case txts of
    [] -> maybeToList context

    -- Heading 1 case
    ('*' : ' ' : line) : rest ->
      maybe id (:) context (Heading 1 (trim line) : parse_lines Nothing rest)

    -- Unordered Lists
    ('-' : ' ' : line) : rest ->
      case context of
        Just (UnorderedList list) ->
          parse_lines (Just (UnorderedList (list <> [trim line]))) rest
        _ ->
          maybe id (:) context (parse_lines (Just (UnorderedList [trim line])) rest)

    -- Ordered lists
    ('#' : ' ' : line) : rest ->
      case context of
        Just (OrderedList list) ->
          parse_lines (Just (OrderedList (list <> [trim line]))) rest
        _ ->
          maybe id (:) context (parse_lines (Just (OrderedList [trim line])) rest)

    -- Code block
    ('>' : ' ' : line) : rest ->
      case context of
        Just (CodeBlock code) ->
          parse_lines (Just (CodeBlock (code <> [trim line]))) rest
        _ ->
          maybe id (:) context (parse_lines (Just (CodeBlock [trim line])) rest)

    -- Paragraphs
    current_line : rest ->
      let
        line = trim current_line
      in
        if line == ""
          then
            --case context of
              -- Nothing -> parse_lines Nothing rest
              -- Just structure -> structure : parse_lines Nothing rest
            maybe id (:) context (parse_lines Nothing rest)
          else
            case context of
              Just (Paragraph paragraph) ->
                parse_lines (Just (Paragraph (unwords [paragraph, line]))) rest
              _ ->
                maybe id (:) context (parse_lines (Just (Paragraph line)) rest)


trim :: String -> String
trim = unwords . words
