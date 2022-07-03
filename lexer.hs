module Lexer where

import Data.Char (isLetter)
import Tokens

tokenize :: String -> [Token]
tokenize ('(' : rest) = LPar : tokenize rest
tokenize (')' : rest) = RPar : tokenize rest
tokenize ('\\' : rest) = Lambda : tokenize rest
tokenize ('.' : rest) = Period : tokenize rest
tokenize (' ' : rest) = tokenize rest
tokenize (c : rest) =
  if isLetter c
    then Variable c : tokenize rest
    else Error ("Parse Error: Unrecignized character '" ++ [c] ++ "'") : tokenize rest
tokenize [] = []