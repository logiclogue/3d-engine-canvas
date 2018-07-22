module Cube (Cube, createCube) where

import Prelude ((<<<))
import LinearAlgebra.Matrix (Matrix, transpose)
import MatrixHelpers (toMatrix)
import Data.Newtype (class Newtype)

newtype Cube = Cube (Matrix Number)

instance newtypeCube :: Newtype Cube (Matrix Number) where
    wrap matrix = Cube matrix
    unwrap (Cube matrix) = matrix

createCube :: Number -> Number -> Number -> Cube
createCube width height depth = Cube (
    (transpose <<< (toMatrix 8 3)) [
        0.0,   0.0,    0.0,
        0.0,   0.0,    depth,
        0.0,   height, 0.0,
        0.0,   height, depth,
        width, 0.0,    0.0,
        width, 0.0,    depth,
        width, height, 0.0,
        width, height, depth]
)
