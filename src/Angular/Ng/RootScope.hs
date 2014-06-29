module Angular.Ng.RootScope where

import FFI

data NgScope
data NgModelKey 
data NgModelRef = NgModelRef NgScope NgModelKey
refPrefix = "m."

ngModelKey :: String -> Fay NgModelKey
ngModelKey = ffi "AngularFayCached['$parse'](%1)"

ngModelRef :: NgScope -> String -> Fay NgModelRef
ngModelRef scope path = do
  k <- ngModelKey $ refPrefix ++ path
  return $ NgModelRef scope k

ngModelRead' :: NgScope -> NgModelKey -> Fay readValue 
ngModelRead' = ffi "%1(%2)"

ngModelRead :: NgModelRef -> Fay readValue
ngModelRead (NgModelRef ng k) = ngModelRead' ng k

ngModelWrite' :: context -> NgModelKey -> newValue -> Fay()
ngModelWrite' = ffi "%2.assign(%1, %3)"

ngModelWrite :: NgModelRef -> newValue -> Fay()
ngModelWrite (NgModelRef ng k) n = ngModelWrite' ng k n

ngModelWriteStr' :: context -> NgModelKey -> String -> Fay()
ngModelWriteStr' = ffi "%2.assign(%1, %3)"

ngModelWriteStr :: NgModelRef -> String -> Fay()
ngModelWriteStr (NgModelRef ng k) n = ngModelWriteStr' ng k n

ngAttachFunc :: NgScope -> String -> (a -> Fay b) -> Fay()
ngAttachFunc = ffi "%1[%2] = %3"

ngAttachFunc2 :: NgScope -> String -> (a -> b -> Fay c) -> Fay()
ngAttachFunc2 = ffi "%1[%2] = %3"

ngAttachFunc3 :: NgScope -> String -> (a -> b -> c -> Fay d) -> Fay()
ngAttachFunc3 = ffi "%1[%2] = %3"

ngAttachFunc4 :: NgScope -> String -> (a -> b -> c -> d -> Fay e) -> Fay()
ngAttachFunc4 = ffi "%1[%2] = %3"

ngDigest :: NgScope -> (a -> Fay()) -> Fay()
ngDigest = ffi "%1.$digest(%2)"

ngApply :: NgScope -> (a -> Fay()) -> Fay()
ngApply = ffi "%1.$apply(%2)"