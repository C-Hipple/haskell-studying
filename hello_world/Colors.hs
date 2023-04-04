
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

isBright :: AnsiColor -> Bool
isBright ac =
  case ac of
    _ Light _ -> True
    _ -> False
