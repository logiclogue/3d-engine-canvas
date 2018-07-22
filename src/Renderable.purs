module Renderable where

import Transformable (class Transformable)
import LinearAlgebra.Matrix (Matrix)
import Data.Newtype (class Newtype, unwrap)

class Transformable a <= Renderable a where
    toMatrix :: a -> Matrix Number

instance renderableMatrixNumber :: Renderable (Matrix Number) where
    toMatrix matrix = matrix

instance renderableNewtypeMatrixNumber :: Newtype a (Matrix Number) => Renderable a where
    toMatrix x = unwrap x
