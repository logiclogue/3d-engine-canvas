module MatrixFunctions where

import TransformationMatrices (xRotationMatrix, yRotationMatrix, zRotationMatrix, scaleMatrix)
import MatrixHelpers (mapColumns)
import LinearAlgebra.Matrix (Matrix, multiply)
import LinearAlgebra.Vector (add) as Vector
import LinearAlgebra.Vector (Vector)
import Transformable (class Transformable)
import Data.Newtype (class Newtype)

newtype MyMatrix = MyMatrix Number

instance newtypeMyMatrix :: Newtype (MyMatrix) where
    wrap (Matrix x) = MyMatrix x
    unwrap (MyMatrix x) = Matrix x

instance transformableMatrix :: Transformable (MyMatrix) where
    rotateX angle m = xRotationMatrix angle `multiply` m
    rotateY angle m = yRotationMatrix angle `multiply` m
    rotateZ angle m = zRotationMatrix angle `multiply` m
    scale factor m = scaleMatrix factor `multiply` m
    shift vector m = mapColumns (\v -> Vector.add v vector) m
