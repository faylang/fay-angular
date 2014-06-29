module Directives.Now where

import Angular.Ng.Compile
import Angular.Module

now :: Directive
now (x:xs) =

init :: NgModule -> Fay()
init m = do
  ngDirective m "Now" 