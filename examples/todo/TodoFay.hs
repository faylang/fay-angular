{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RebindableSyntax  #-}

module TodoFay (
    Todo(..)
  , TodoState(..)
  , initialState
  , remaining
  , addTodo
  , archive
  , todoSC
) where

import Angular
import Fay.Text
import FFI
import Prelude

data Todo = Todo
  { text :: Text
  , done :: Bool
  }

data TodoState = TS
  { todos    :: [Todo]
  , todoText :: Text
  }

initialTodos :: [Todo]
initialTodos =
    [ Todo "Learn Fay" False
    , Todo "Write a fay-angular app" False
    ]

initialState :: TodoState
initialState = TS initialTodos ""

addTodo :: TodoState -> TodoState
addTodo (TS ts0 txt) = TS (ts0 ++ [Todo txt False]) ""

remaining :: TodoState -> Int
remaining = Prelude.length . filter (not . done) . todos

archive :: TodoState -> TodoState
archive (TS ts txt) = TS (filter (not . done) ts) txt

todoSC = SC ["addTodo", "archive"] ["remaining"]
