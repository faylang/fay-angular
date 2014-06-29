module Controllers.BarCtrl where

import Angular.Ng.RootScope
import Angular.Ng.Controller 

barCtrl :: NgController
barCtrl scope _ = do
  let attach = ngAttachFunc scope
  let model  = ngModelRef   scope

  jello <- model "jello"
  ngModelWriteStr jello "yellow world"


  attach "squirles" $ \_ -> ngModelWriteStr jello "yellow squirles?"
