module Pyramid(Pyramid, createPyramid) where

import Prelude ((/), ($))
import LinearAlgebra.Matrix (Matrix)
import Data.Newtype (class Newtype)
import MatrixHelpers (toMatrix)

newtype Pyramid = Pyramid (Matrix Number)

createPyramid :: Number -> Number -> Number -> Pyramid
createPyramid width height depth = Pyramid $ toMatrix 3 5 [
    0.0, width, 0.0,   width, (width / 2.0),
    0.0, 0.0,   0.0,   0.0,   height,
    0.0, 0.0,   depth, depth, (depth / 2.0)
]

instance newtypePyramid :: Newtype Pyramid (Matrix Number) where
    wrap matrix = Pyramid matrix
    unwrap (Pyramid matrix) = matrix
