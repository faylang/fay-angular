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
  let f = getTime >>= show
  print f
  --time <- getTime
  --setHtml (pack . show $ time) element 
  return ()

now :: Directive
now [l] = do
  def <- newNgDirectiveDef
  ngDirectiveDef def l
  return def

init :: NgModule -> Fay()
init m = do
  now [(Link link)] >>= ngDirective m "now"