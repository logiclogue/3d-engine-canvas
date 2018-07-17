module MatrixFunctions where

import Prelude (($))

import TransformationMatrices (xRotationMatrix, yRotationMatrix, zRotationMatrix, scaleMatrix)
import MatrixHelpers (mapColumns)
import LinearAlgebra.Matrix (Matrix, multiply)
import LinearAlgebra.Vector (add) as Vector
import LinearAlgebra.Vector (Vector)
import Transformable (class Transformable)
import Data.Newtype (class Newtype, wrap, unwrap)

newtype MyMatrix = MyMatrix (Matrix Number)

instance newtypeMyMatrix :: Newtype MyMatrix (Matrix Number) where
    wrap matrix = MyMatrix matrix
    unwrap (MyMatrix matrix) = matrix

instance transformableMatrix :: Transformable (MyMatrix) where
    rotateX angle m = wrap $ xRotationMatrix angle `multiply` (unwrap m)
    rotateY angle m = wrap $ yRotationMatrix angle `multiply` (unwrap m)
    rotateZ angle m = wrap $ zRotationMatrix angle `multiply` (unwrap m)
    scale factor m = wrap $ scaleMatrix factor `multiply` (unwrap m)
    shift vector m = wrap $ mapColumns (\v -> Vector.add v vector) (unwrap m)
