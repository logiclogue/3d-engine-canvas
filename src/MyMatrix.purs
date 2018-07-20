module MatrixFunctions (MyMatrix) where

import Prelude (($))

import LinearAlgebra.Matrix (Matrix)
import Transformable (
    class Transformable, rotateX, rotateY, rotateZ, scale, shift)
import Data.Newtype (class Newtype, wrap, unwrap)

newtype MyMatrix = MyMatrix (Matrix Number)

instance newtypeMyMatrix :: Newtype MyMatrix (Matrix Number) where
    wrap matrix = MyMatrix matrix
    unwrap (MyMatrix matrix) = matrix

instance transformableMyMatrix :: Transformable (MyMatrix) where
    rotateX angle m = wrap $ rotateX angle (unwrap m)
    rotateY angle m = wrap $ rotateY angle (unwrap m)
    rotateZ angle m = wrap $ rotateZ angle (unwrap m)
    scale factor m = wrap $ scale factor (unwrap m)
    shift vector m = wrap $ shift vector (unwrap m)
