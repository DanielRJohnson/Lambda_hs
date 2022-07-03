module Eval where

import AST

type RuntimeError = String

eval :: Term -> Either RuntimeError Term
eval t = evalInEnv t []

evalInEnv :: Term -> Env -> Either RuntimeError Term
evalInEnv (VariableT name) env =
  case lookup name env of
    Just t -> Right t
    Nothing -> Left "Runtime Error: Name not found in environment."
evalInEnv (ApplicationT fn actual) env =
  case evalInEnv fn env of
    Right (ClosureT arg body closedEnv) -> do
      evaledValue <- evalInEnv actual env
      let extendedEnv = (arg, evaledValue) : closedEnv ++ env
       in evalInEnv body extendedEnv
    _ -> Left "Runtime Error: Application of non-function."
evalInEnv (LambdaT arg body) env = Right (ClosureT arg body env)
evalInEnv closure env = Right closure