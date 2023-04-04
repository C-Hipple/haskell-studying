newtype Word8 = Word8 Int
  deriving Show

data Color
  = RGB Word8 Word8 Word8
  deriving Show


getBluePart :: Color -> Word8
getBluePart color =
  case color of
    RGB _ _ blue -> blue


getRedPart :: Color -> Word8
getRedPart color =
  case color of
    RGB red _ _ -> red

----------------------------------
-- newtype Dark = Dark Int
--   deriving Show
-- newtype Light = Light Int
--   deriving Show

-- don't actually need these
-- newtype Black = Black Int
-- newtype Red = Red Int
-- newtype Green = Green Int
-- newtype Yellow = Yellow Int
-- newtype Blue = Blue Int
-- newtype Magenta = Magenta Int
-- newtype Cyan = Cyan Int
-- newtype White = White Int

data Brightness
  = Dark
  | Light
  deriving Show

data EightColor
  = Black
  | Red
  | Green
  | Yellow
  | Blue
  | Magenta
  | Cyan
  | White
  deriving Show

data AnsiColor
  = AnsiColor Brightness EightColor
  deriving Show


getRGBFromEightColor :: AnsiColor -> Color
getRGBFromEightColor ansicolor =
  case ansicolor of
    AnsiColor Dark Red -> RGB (Word8 255) (Word8 0) (Word8 0)
    _ -> RGB (Word8 0) (Word8 0) (Word8 0)


intsToRGB :: Int -> Int -> Int -> Color
intsToRGB r g b =
  RGB (Word8 r) (Word8 g) (Word8 b)

isBright :: AnsiColor -> Bool
isBright ac =
  case ac of
    AnsiColor Light _ -> True
    AnsiColor Dark _ -> False


-- ansiToUbuntu :: AnsiColor -> Color
-- ansiToUbuntu ac =
--   case ac of
--     AnsiColor Red _ = intsToRGB 222 56 43
--     AnsiColor Green _= intsToRGB 57 181 74

ansiToUbuntu :: AnsiColor -> Color
ansiToUbuntu ansiColor =
  case ansiColor of
    AnsiColor brightness color ->
      case brightness of
        Dark ->
          case color of
            Black -> intsToRGB 0 0 0
            Red -> intsToRGB 194 54 33
            Green -> intsToRGB 37 188 36
            Yellow -> intsToRGB 173 173 39
            Blue -> intsToRGB 73 46 225
            Magenta -> intsToRGB 211 56 211
            Cyan -> intsToRGB 51 187 200
            White -> intsToRGB 203 204 205

        Light ->
          case color of
            Black -> intsToRGB 129 131 131
            Red -> intsToRGB 252 57 31
            Green -> intsToRGB 49 231 34
            Yellow -> intsToRGB 234 236 35
            Blue -> intsToRGB 88 51 255
            Magenta -> intsToRGB 249 53 248
            Cyan -> intsToRGB 20 240 240
            White -> intsToRGB 233 235 235


main :: IO ()
main = do
  let c = RGB (Word8 255) (Word8 255) (Word8 2)
  let ac = AnsiColor Dark Red
  print $ getBluePart c
  print $ getRedPart c
  print $ getRGBFromEightColor ac
  print $ getRGBFromEightColor (AnsiColor Light Cyan)
  print $ isBright (AnsiColor Light Cyan)
  print $ isBright (AnsiColor Dark Cyan)
  print $ (intsToRGB 12 21 41)
