{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RebindableSyntax  #-}

module BeersFay (
    beers
) where

import Fay.Text
import Prelude

beers :: [Int]
beers = [0..6]
