module Main (main) where

import Angular
import FFI

setScopeStr :: NgScope -> String -> String -> Fay()
setScopeStr = ffi "%1[%2] = %3"

barCtrl :: NgScope -> Fay()
barCtrl scope = do
  setScopeStr scope "jello" "yellow"

main :: Fay()
main = do
  ctrl <- newNgModule "foo" [] >>= ngController "bar" barCtrl
  print ctrl