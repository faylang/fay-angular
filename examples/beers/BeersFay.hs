{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RebindableSyntax  #-}

module BeersFay (
    beers
  , beerForms_en_us
  , beerForms_sk
) where

import Angular
import Fay.Text
import FFI
import Prelude

beers :: [Int]
beers = [0..6]

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
