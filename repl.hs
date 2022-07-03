module Repl where

import AST
import Eval
import Lexer
import Parser
import System.Console.Haskeline
import Tokens

runREPL :: IO ()
runREPL = do
  putStrLn "lambda_hs REPL (\"exit\" or CTRL+C to exit)"
  runInputT defaultSettings loop
  where
    loop :: InputT IO ()
    loop = do
      minput <- getInputLine "λ> "
      case minput of
        Nothing -> return ()
        Just "exit" -> return ()
        Just input ->
          let tokens = tokenize input
              errors = errTokens tokens
           in do
                if null errors
                  then case parse tokens of --outputStrLn (termToString $ eval $ parse tokens)
                    Right t -> case eval t of
                      Right res -> outputStrLn $ termToString res
                      Left e -> outputStrLn e
                    Left e -> outputStrLn e
                  else outputStrLn (joinErrStrings errors)
                loop
