module Angular.Ng.Compile where

import FFI
import JQuery
import Angular.Ng.RootScope
import Angular.Module

data Attrs

data DirectiveDefConf = Restrict Char
                      | Transclude Bool
                      | TemplateUrl String
                      | Scope
                      | Link Linking

data DirectiveDef

type DirectiveName = String
type Directive     = [DirectiveDefConf] -> Fay DirectiveDef

type Linking       = (NgScope -> JQuery -> Attrs -> Fay())

--                         DirectiveName             
ngDirective :: NgModule -> String -> DirectiveDef -> Fay()
ngDirective = ffi "%1.directive(%2, function(){ return %3 })"

newNgDirectiveDef   :: Fay DirectiveDef
newNgDirectiveDef   = ffi "new Object()"

ngDirectiveDefFunc  :: DirectiveDef -> String -> (a -> Fay()) -> Fay()
ngDirectiveDefFunc  = ffi "%1[%2] = %3"
 
ngDirectiveDefFunc2 :: DirectiveDef -> String -> (a -> b -> Fay()) -> Fay()
ngDirectiveDefFunc2 = ffi "%1[%2] = %3"

ngDirectiveDefFunc3 :: DirectiveDef -> String -> (a -> b -> c -> Fay()) -> Fay()
ngDirectiveDefFunc3 = ffi "%1[%2] = %3"

ngDirectiveDefStr   :: DirectiveDef -> String -> String -> Fay()
ngDirectiveDefStr = ffi "%1[%2] = %3"

ngDirectiveDefBool  :: DirectiveDef -> String -> Bool -> Fay()
ngDirectiveDefBool = ffi "%1[%2] = %3"

ngDirectiveDef' ::  [DirectiveDefConf] -> DirectiveDef -> Fay DirectiveDef
ngDirectiveDef' []               d = return d 
ngDirectiveDef' [(Link linking)] d = ngDirectiveDefFunc3 d "link" linking >>= \_ -> return d
ngDirectiveDef' [(Transclude b)] d = ngDirectiveDefBool  d "transclude" b  >>= \_ -> return d
ngDirectiveDef' (x:xs) d = do 
  ngDirectiveDef' [x]  d
  ngDirectiveDef' xs   d
  return d

ngDirectiveDef :: [DirectiveDefConf] -> Fay DirectiveDef
ngDirectiveDef confs = newNgDirectiveDef >>= ngDirectiveDef' confs >>= return


