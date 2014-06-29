module Main (main) where

import Angular
import FFI

barCtrl :: NgScope -> NgInjector -> Fay()
barCtrl scope injector = do
  jello <- ngModelRef "jello" scope
  ngModelWriteStr jello "yellow world"

main :: Fay()
main = do
  ctrl <- newNgModule "foo" [] >>= ngController "bar" barCtrl
  putStrLn "angular fay is moving"