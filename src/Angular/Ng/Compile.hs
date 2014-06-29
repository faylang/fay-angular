module Angular.Ng.Compile where

import FFI
import Angular.Ng.RootScope
import Angular.Module

data JqLite
data Attrs

data DirectiveDefConf = Restrict Char
                      | Transclude Bool
                      | TemplateUrl String
                      | Scope
                      | Link (NgScope -> JqLite -> Attrs -> Fay())

data DirectiveDef

type DirectiveName = String
type Directive     = ([DirectiveDefConf] -> DirectiveDef)

--                         DirectiveName             Directive
ngDirective :: NgModule -> String -> ([DirectiveDefConf] -> DirectiveDef) -> Fay()
ngDirective = ffi "%1.directive(%2, function(){ return %3 })"