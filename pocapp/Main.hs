module Main (main) where

import Angular.Module
import Angular.Ng.Controller
import Controllers.BarCtrl

import qualified Directives.Now as Dn

main :: Fay()
main = do
  newNgModule "foo" [] >>= ngController "bar" barCtrl >>= Dn.init
  putStrLn "angular fay is moving"