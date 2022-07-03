module Tokens where

data Token
  = LPar
  | RPar
  | Lambda
  | Period
  | Variable Char
  | Error String
  deriving (Show, Eq)

isErr :: Token -> Bool
isErr (Error _) = True
isErr _ = False

errTokens :: [Token] -> [Token]
errTokens = filter isErr

joinErrStrings :: [Token] -> String
joinErrStrings (Error e : rest) = e ++ "\n" ++ joinErrStrings rest
joinErrStrings [] = ""
joinErrStrings _ = ""