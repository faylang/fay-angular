{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RebindableSyntax  #-}

module BeersFay (
    beers
  , ngPluralize
  , beerForms_en_us
  , beerForms_sk
) where

import Fay.Text
import FFI
import Prelude

beers :: [Int]
beers = [0..6]

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

beerForms_en_us = ngPlurals
  { ngPluralizeZero  = Defined "no beers"
  , ngPluralizeOne   = Defined "{} beer"
  , ngPluralizeOther = Defined "{} beers"
  }

beerForms_sk = ngPlurals
  { ngPluralizeZero  = Defined "žiadne pivo"
  , ngPluralizeOne   = Defined "{} pivo"
  , ngPluralizeFew   = Defined "{} pivá"
  , ngPluralizeOther = Defined "{} pív"
  }
