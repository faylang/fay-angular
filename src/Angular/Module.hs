module Angular.Module where

import FFI

data NgModule

newNgModule :: String -> [String] -> Fay NgModule
newNgModule = ffi "angular.module(%1, %2)"

ngModule :: String -> Fay NgModule
ngModule = ffi "angular.module(%1)"