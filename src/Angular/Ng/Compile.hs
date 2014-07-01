module Angular.Ng.Compile where

import FFI
import JQuery
import Angular.Ng.RootScope
import Angular.Ng.Controller 
import Angular.Module

type DirectiveName = String
type Directive     = [DirectiveDefinitionConf] -> Fay DirectiveDefinition
type Linking       = (NgScope -> JQuery -> Attrs -> Fay())
type Compiling     = (NgScope -> JQuery -> Attrs -> Fay Linking)

data Attrs

data DirectiveDefinitionConf = Priority Int
                             | Template String
                             | TemplateUrl String
                             | Transclude Bool
                             | Restrict String
                             | Scope Bool -- not done
                             | Controller NgController
                             | ControllerAs String
                             | Require String
                             | Link Linking
                             | Compile Compiling

data DirectiveDefinition

--                         DirectiveName             
ngDirective :: NgModule -> String -> DirectiveDefinition -> Fay()
ngDirective = ffi "%1.directive(%2, function(){ return %3 })"

newNgDirectiveDefinition   :: Fay DirectiveDefinition
newNgDirectiveDefinition   = ffi "new Object()"

ngDirectiveDefinitionFunc2 :: DirectiveDefinition -> String -> (a -> b -> Fay()) -> Fay()
ngDirectiveDefinitionFunc2 = ffi "%1[%2] = %3"

ngDirectiveDefinitionFunc3 :: DirectiveDefinition -> String -> (a -> b -> c -> Fay()) -> Fay()
ngDirectiveDefinitionFunc3 = ffi "%1[%2] = %3"

ngDirectiveDefinitionFunc3' :: DirectiveDefinition -> String -> (a -> b -> c -> Fay Linking) -> Fay()
ngDirectiveDefinitionFunc3' = ffi "%1[%2] = %3"

ngDirectiveDefinitionStr   :: DirectiveDefinition -> String -> String -> Fay()
ngDirectiveDefinitionStr   = ffi "%1[%2] = %3"

ngDirectiveDefinitionBool  :: DirectiveDefinition -> String -> Bool -> Fay()
ngDirectiveDefinitionBool  = ffi "%1[%2] = %3"

ngDirectiveDefinitionInt   :: DirectiveDefinition -> String -> Int -> Fay()
ngDirectiveDefinitionInt   = ffi "%1[%2] = %3"

ngDirectiveDefinition' ::  [DirectiveDefinitionConf] -> DirectiveDefinition -> Fay DirectiveDefinition
ngDirectiveDefinition' []                 d = return d 
ngDirectiveDefinition' [(Priority x)]     d = ngDirectiveDefinitionInt    d "priority"     x  >>= \_ -> return d
ngDirectiveDefinition' [(Template x)]     d = ngDirectiveDefinitionStr    d "template"     x  >>= \_ -> return d
ngDirectiveDefinition' [(TemplateUrl x)]  d = ngDirectiveDefinitionStr    d "templateUrl"  x  >>= \_ -> return d
ngDirectiveDefinition' [(Transclude x)]   d = ngDirectiveDefinitionBool   d "transclude"   x  >>= \_ -> return d
ngDirectiveDefinition' [(Restrict x)]     d = ngDirectiveDefinitionStr    d "restrict"     x  >>= \_ -> return d
ngDirectiveDefinition' [(Scope x)]        d = ngDirectiveDefinitionBool   d "scope"        x  >>= \_ -> return d
ngDirectiveDefinition' [(Controller x)]   d = ngDirectiveDefinitionFunc2  d "controller"   x  >>= \_ -> return d
ngDirectiveDefinition' [(ControllerAs x)] d = ngDirectiveDefinitionStr    d "controllerAs" x  >>= \_ -> return d
ngDirectiveDefinition' [(Require x)]      d = ngDirectiveDefinitionStr    d "require"      x  >>= \_ -> return d
ngDirectiveDefinition' [(Link x)]         d = ngDirectiveDefinitionFunc3  d "link"         x  >>= \_ -> return d
ngDirectiveDefinition' [(Compile x)]      d = ngDirectiveDefinitionFunc3' d "compile"      x  >>= \_ -> return d

ngDirectiveDefinition' (x:xs) d = do ngDirectiveDefinition' [x]  d
                                     ngDirectiveDefinition' xs   d
                                     return d

ngDirectiveDefinition :: [DirectiveDefinitionConf] -> Fay DirectiveDefinition
ngDirectiveDefinition confs = newNgDirectiveDefinition >>= ngDirectiveDefinition' confs >>= return


