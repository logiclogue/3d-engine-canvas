module MatrixHelpers where

import Prelude
import Data.Foldable (foldr)
import LinearAlgebra.Vector (Vector)
import LinearAlgebra.Matrix (Matrix, columns, rows, fromArray, zeros, transpose)
import Data.Array (length)
import Data.Maybe (fromMaybe)

toMatrix :: Int -> Int -> Array Number -> Matrix Number
toMatrix r c = fromMaybe (zeros r c) <<< fromArray r c

toTransformationMatrix :: Array Number -> Matrix Number
toTransformationMatrix = toMatrix 3 3

mapColumns :: forall a. (Vector a -> Vector a) -> Matrix a -> Matrix a
mapColumns f m = fromMaybe m $ (transpose <$> fromArray x y array) where
    array = foldr append [] (map f xs)
    xs = columns m
    x = length xs
    y = length (rows m)
