module Main (main) where

import Angular.Module
import Angular.Ng.Controller
import Controllers.BarCtrl

main :: Fay()
main = do
  ctrl <- newNgModule "foo" [] >>= ngController "bar" barCtrl
  putStrLn "angular fay is moving"