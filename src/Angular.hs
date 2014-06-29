module Angular where

import FFI

data NgScope
data NgModule
data NgController

newNgModule :: String -> [String] -> Fay NgModule
newNgModule = ffi "angular.module(%1, %2)"

ngModule :: String -> Fay NgModule
ngModule = ffi "angular.module(%1)"

ngCtrlPrep :: [String] -> (a -> Fay()) -> Fay [b]
ngCtrlPrep = ffi "(function(){})()"

ngController ::  String -> (NgScope -> Fay()) -> NgModule -> Fay NgController
ngController = ffi "%3.controller(%1, ['$scope', %2])"
