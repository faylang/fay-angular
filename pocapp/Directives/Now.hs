module Directives.Now where

import JQuery
import Fay.Text
import FFI
import Angular.Ng.Compile
import Angular.Module

getTime :: Fay int
getTime = ffi "Date.now()"

link :: Linking
link scope element attrs = do
  time <- getTime
  setHtml (pack . show $ time) element
  return ()

init :: NgModule -> Fay()
init m = do
  ngDirectiveDef [(Link link)] >>= ngDirective m "now"

init _ = return ()