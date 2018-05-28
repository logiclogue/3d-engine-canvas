module MatrixFunctions where

import TransformationMatrices (xRotationMatrix, yRotationMatrix, scaleMatrix)
import MatrixHelpers (mapColumns)
import LinearAlgebra.Matrix (Matrix, multiply)
import LinearAlgebra.Vector (add) as Vector

rotateX :: Number -> Matrix Number -> Matrix Number
rotateX angle m = xRotationMatrix angle `multiply` m

rotateY :: Number -> Matrix Number -> Matrix Number
rotateY angle m = yRotationMatrix angle `multiply` m

scale :: Number -> Matrix Number -> Matrix Number
scale factor m = scaleMatrix factor `multiply` m

shiftX :: Number -> Matrix Number -> Matrix Number
shiftX n matrix = mapColumns (\v -> Vector.add v [n, 0.0]) matrix
