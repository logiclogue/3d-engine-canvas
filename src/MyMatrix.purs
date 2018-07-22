module MyMatrix (MyMatrix) where

import LinearAlgebra.Matrix (Matrix)
import Data.Newtype (class Newtype)

newtype MyMatrix = MyMatrix (Matrix Number)

instance newtypeMyMatrix :: Newtype MyMatrix (Matrix Number) where
    wrap matrix = MyMatrix matrix
    unwrap (MyMatrix matrix) = matrix
