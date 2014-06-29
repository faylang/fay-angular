module Angular.Auto.Injector where

import FFI

data NgInjector

ngInject :: NgInjector -> String -> Fay a 
ngInject = ffi "%1.get(%2)"