module Angular where

import FFI

data NgScope
data NgModule
data NgController

newNgModule :: String -> [String] -> Fay NgModule
newNgModule = ffi "angular.module(%1, %2)"

ngModule :: String -> Fay NgModule
ngModule = ffi "angular.module(%1)"

ngController :: NgModule -> String -> (a -> Fay()) -> Fay NgController
ngController = ffi "%1.controller(%2, ['$scope', %3])"
