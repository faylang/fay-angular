{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RebindableSyntax  #-}

module Angular (
    StateController(..)

  , Directive(..)
  , directive

  , NgPluralize(..)
  , ngPluralize
  , ngPlurals
) where

import Fay.Text
import FFI
import Prelude

data StateController a = SC
  { muts :: [(a -> a)]
  , gets :: [Text]
  }

data Directive = Directive
  { require    :: Defined Text
  , restrict   :: Defined Text
  , transclude :: Defined Bool
  , template   :: Defined Text
  , replace    :: Defined Bool
  }

directive :: Directive
directive = Directive Undefined Undefined Undefined Undefined Undefined


-- | http://docs.angularjs.org/api/ng.directive:ngPluralize
data NgPluralize = NgPluralize
  { ngPluralizeZero :: Defined Text
  , ngPluralizeOne :: Defined Text
  , ngPluralizeTwo :: Defined Text
  , ngPluralizeFew :: Defined Text
  , ngPluralizeMany :: Defined Text
  , ngPluralizeOther :: Defined Text
  }

ngPluralize :: NgPluralize -> Fay ()
ngPluralize = ffi "\
  \ (function(o) { \
    \ delete o['instance']; \
    \ if (\"ngPluralizeZero\" in o) { o[0] = o.ngPluralizeZero; delete o.ngPluralizeZero; }; \
    \ if (\"ngPluralizeOne\" in o) { o['one'] = o.ngPluralizeOne; delete o.ngPluralizeOne; }; \
    \ if (\"ngPluralizeTwo\" in o) { o['two'] = o.ngPluralizeTwo; delete o.ngPluralizeTwo; }; \
    \ if (\"ngPluralizeFew\" in o) { o['few'] = o.ngPluralizeFew; delete o.ngPluralizeFew; }; \
    \ if (\"ngPluralizeMany\" in o) { o['many'] = o.ngPluralizeMany; delete o.ngPluralizeMany; }; \
    \ if (\"ngPluralizeOther\" in o) { o['other'] = o.ngPluralizeOther; delete o.ngPluralizeOther; }; \
    \ return o; \
  \ })(%1)"

ngPlurals :: NgPluralize
ngPlurals = NgPluralize Undefined Undefined Undefined Undefined Undefined Undefined
