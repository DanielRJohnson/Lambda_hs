module Parser where

import AST
import Tokens

type ParseError = String

parse :: [Token] -> Either ParseError Term
parse tokens = fst (parseSingle tokens)

parseSingle :: [Token] -> (Either ParseError Term, [Token])
parseSingle (Variable name : rest) = (Right (VariableT name), rest)
parseSingle (Lambda : Variable arg : Period : body) =
  let (bodyTerm, rest) = parseSingle body
   in case bodyTerm of
        Right t -> (Right (LambdaT arg t), rest)
        Left e -> (Left e, [])
parseSingle (LPar : rest) =
  let (fn, codeAfterFn) = parseSingle rest
      (value, codeAfterValue) = parseSingle codeAfterFn
   in case codeAfterValue of
        (RPar : codeAfterApp) -> case fn of
          Right t -> case value of
            Right v -> (Right (ApplicationT t v), codeAfterApp)
            Left e -> (Left e, [])
          Left e -> (Left e, [])
        _ -> (Left "Parse Error: Invalid Application.", [])
parseSingle _ = (Left "Parse Error: Some pattern did not match any of x | \\x. x | (x x).", [])