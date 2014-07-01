module Angular.Ng.Controller where

import FFI
import Angular.Ng.RootScope
import Angular.Auto.Injector
import Angular.Module
 
type NgController = (NgScope -> NgInjector -> Fay())

--                         This is really just NgController
--                         But ffi does not support aliases yet
ngController ::  String -> (NgScope -> NgInjector -> Fay()) -> NgModule -> Fay NgModule
ngController = ffi "%3.controller(%1, ['$scope','$injector', %2])"