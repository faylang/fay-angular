{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RebindableSyntax  #-}

module ComponentsFay (
    tabs
  , pane
) where

import Angular
import Fay.Text
import FFI
import Prelude

tabs :: Directive
tabs = directive
  { restrict   = Defined "E"
  , transclude = Defined True
  , template   = Defined tabsTemplate
  , replace    = Defined True
  }

tabsTemplate :: Text
tabsTemplate = Fay.Text.concat
    [ "<div class=\"tabbable\">"
    ,  "<ul class=\"nav nav-tabs\">"
    ,    "<li ng-repeat=\"pane in panes\" ng-class=\"{active:pane.selected}\">"
    ,      "<a href=\"\" ng-click=\"select(pane)\">{{pane.title}}</a>"
    ,    "</li>"
    ,  "</ul>"
    ,  "<div class=\"tab-content\" ng-transclude></div>"
    ,"</div>"
    ]
    

pane :: Directive
pane = directive
  { require    = Defined "^tabs"
  , restrict   = Defined "E"
  , transclude = Defined True
  , template   = Defined paneTemplate
  , replace    = Defined True
  }

paneTemplate :: Text
paneTemplate = "<div class=\"tab-pane\" ng-class=\"{active: selected}\" ng-transclude></div>"
