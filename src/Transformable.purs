module Transformable (
    class Transformable, rotateX, rotateY, rotateZ, scale, shift) where

import TransformationMatrices (
    xRotationMatrix, yRotationMatrix, zRotationMatrix, scaleMatrix)
import MatrixHelpers (mapColumns)
import LinearAlgebra.Matrix (Matrix, multiply)
import LinearAlgebra.Vector (add) as Vector
import LinearAlgebra.Vector (Vector)

class Transformable a where
    rotateX :: Number -> a -> a
    rotateY :: Number -> a -> a
    rotateZ :: Number -> a -> a
    scale :: Number -> a -> a
    shift :: Vector Number -> a -> a

instance transformableMatrixNumber :: Transformable (Matrix Number) where
    rotateX angle m = xRotationMatrix angle `multiply` m
    rotateY angle m = yRotationMatrix angle `multiply` m
    rotateZ angle m = zRotationMatrix angle `multiply` m
    scale factor m = scaleMatrix factor `multiply` m
    shift vector m = mapColumns (\v -> Vector.add v vector) m
