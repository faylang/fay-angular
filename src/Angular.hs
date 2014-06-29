module Angular where

import FFI

data Ng
data NgScope
data NgInjector
data NgModule
data NgController

data NgModelKey 
data NgModelRef = NgModelRef NgScope NgModelKey
refPrefix = "m."

newNgModule :: String -> [String] -> Fay NgModule
newNgModule = ffi "angular.module(%1, %2)"

ngModule :: String -> Fay NgModule
ngModule = ffi "angular.module(%1)"

ngDigest :: NgScope -> Fay NgScope
ngDigest = ffi "%1.$digest()"

ngInject :: NgInjector -> String -> Fay Ng 
ngInject = ffi "%1.get(%2)"

ngModelKey :: String -> Fay NgModelKey
ngModelKey = ffi "angular.injector(['ng']).get('$parse')(%1)"

ngModelRef :: String -> NgScope -> Fay NgModelRef
ngModelRef path ng = do
  k <- ngModelKey $ refPrefix ++ path
  return $ NgModelRef ng k

ngModelRead' :: a -> NgModelKey -> Fay b 
ngModelRead' = ffi "%1(%2)"

ngModelRead :: NgModelRef -> Fay a
ngModelRead (NgModelRef ng k) = ngModelRead' ng k

ngModelWrite' :: a -> NgModelKey -> n -> Fay()
ngModelWrite' = ffi "%2.assign(%1, %3)"

ngModelWrite :: NgModelRef -> n -> Fay()
ngModelWrite (NgModelRef ng k) n = ngModelWrite' ng k n

ngModelWriteStr' :: a -> NgModelKey -> String -> Fay()
ngModelWriteStr' = ffi "%2.assign(%1, %3)"

ngModelWriteStr :: NgModelRef -> String -> Fay()
ngModelWriteStr (NgModelRef ng k) n = ngModelWriteStr' ng k n

ngController ::  String -> (NgScope -> NgInjector -> Fay()) -> NgModule -> Fay NgController
ngController = ffi "%3.controller(%1, ['$scope','$injector', %2])"
