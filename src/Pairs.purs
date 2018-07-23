module Pairs(pairs) where

import Prelude ((<>))
import Data.Tuple (Tuple(Tuple))
import Data.Array (tail, zip, head, last)
import Data.Maybe (fromMaybe)

pairs :: forall a. Array a -> a -> Array (Tuple a a)
pairs xs default = (zip xs (tail' xs)) <> [lastTuple]
  where
    tail' ys = fromMaybe [] (tail ys)
    lastTuple = Tuple (fromMaybe default (head xs)) (fromMaybe default (last xs))
