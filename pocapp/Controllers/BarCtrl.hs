module Controllers.BarCtrl where

import Angular.Ng.RootScope
import Angular.Ng.Controller 

barCtrl :: NgController
barCtrl scope _ = do
  let attach = ngAttachFunc scope
  let model  = ngModelRef   scope

  jello <- model "jello"
  col   <- model "collection"

  ngModelWriteStr jello "yellow world"
  ngModelWriteLst col ["what","who","why"]

  print scope

  attach "squirles" $ \_ -> ngModelWriteStr jello "yellow squirles?"
