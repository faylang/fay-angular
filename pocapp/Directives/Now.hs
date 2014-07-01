module Directives.Now where

import JQuery
import Fay.Text
import FFI
import Angular.Ng.Compile
import Angular.Module

getTime :: Fay int
getTime = ffi "Date.now()"

link :: Linking
link _ element _ = do
  time <- getTime
  setHtml (pack . show $ time) element
  return ()

init :: NgModule -> Fay()
init m = do
  ngDirectiveDefinition [(Link link)] >>= ngDirective m "now"

init _ = return ()