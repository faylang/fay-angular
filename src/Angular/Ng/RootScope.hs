module Angular.Ng.RootScope where

import FFI

data NgScope
data NgModelKey 
data NgModelRef = NgModelRef NgScope NgModelKey
refPrefix = "m."

ngDigest :: NgScope -> Fay NgScope
ngDigest = ffi "%1.$digest()"

--ngApply :: NgScope -> -> Fay NgScope

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


