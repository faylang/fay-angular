module Main (main) where

import Angular
import FFI

barCtrl :: NgController
barCtrl scope _ = do
  let attach = ngAttachFunc scope
  let model  = ngModelRef scope

  jello <- model "jello"
  ngModelWriteStr jello "yellow world"


  attach "squirles" $ \_ ->
    ngModelWriteStr jello "yellow squirles?"

main :: Fay()
main = do
  ctrl <- newNgModule "foo" [] >>= ngController "bar" barCtrl
  putStrLn "angular fay is moving"