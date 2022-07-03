module AST where

data Term
  = LambdaT Char Term
  | ClosureT Char Term Env
  | VariableT Char
  | ApplicationT Term Term
  deriving (Show, Eq)

type Env = [(Char, Term)]

termToString :: Term -> String
termToString (ApplicationT left right) = "(" ++ termToString left ++ " " ++ termToString right ++ ")"
termToString (LambdaT arg body) = "\\" ++ [arg] ++ ". " ++ termToString body
termToString (ClosureT arg body env) = "\\" ++ [arg] ++ ". " ++ termToString body
termToString (VariableT char) = [char]
