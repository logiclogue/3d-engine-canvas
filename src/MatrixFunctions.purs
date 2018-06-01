module MatrixFunctions where

import TransformationMatrices (xRotationMatrix, yRotationMatrix, zRotationMatrix, scaleMatrix)
import MatrixHelpers (mapColumns)
import LinearAlgebra.Matrix (Matrix, multiply)
import LinearAlgebra.Vector (add) as Vector
import LinearAlgebra.Vector (Vector)
import Transformable (class Transformable)

data MyMatrix = Matrix Number

instance transformableMatrix :: Transformable (MyMatrix) where
    rotateX angle m = xRotationMatrix angle `multiply` m
    rotateY angle m = yRotationMatrix angle `multiply` m
    rotateZ angle m = zRotationMatrix angle `multiply` m
    scale factor m = scaleMatrix factor `multiply` m
    shift vector m = mapColumns (\v -> Vector.add v vector) m
