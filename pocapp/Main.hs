module Main (main) where

import Angular.Module
import Angular.Ng.Controller
import Controllers.BarCtrl

import Angular.Ng.Compile
import qualified Directives.Now as Dn

main :: Fay()
main = do
  _ <- newNgModule "foo" [] >>= ngController "bar" barCtrl
  _ <- ngModule "foo" >>= Dn.init
  putStrLn "angular fay is moving"