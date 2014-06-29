module Main (main) where

import Angular
import FFI

setScopeStr :: NgScope -> String -> String -> Fay()
setScopeStr = ffi "%1[%2] = %3"

main :: Fay()
main = do
  foo   <- newNgModule "foo" []
  bar   <- ngController foo "bar" $ \scope ->
    setScopeStr scope "jello" "yellow"
  putStrLn "murf"