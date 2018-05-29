module MatrixFunctions where

import TransformationMatrices (xRotationMatrix, yRotationMatrix, scaleMatrix)
import MatrixHelpers (mapColumns)
import LinearAlgebra.Matrix (Matrix, multiply)
import LinearAlgebra.Vector (add) as Vector
import LinearAlgebra.Vector (Vector)

rotateX :: Number -> Matrix Number -> Matrix Number
rotateX angle m = xRotationMatrix angle `multiply` m

rotateY :: Number -> Matrix Number -> Matrix Number
rotateY angle m = yRotationMatrix angle `multiply` m

scale :: Number -> Matrix Number -> Matrix Number
scale factor m = scaleMatrix factor `multiply` m

shift :: Vector Number -> Matrix Number -> Matrix Number
shift vector matrix = mapColumns (\v -> Vector.add v vector) matrix

shiftX :: Number -> Matrix Number -> Matrix Number
shiftX n = shift [n, 0.0, 0.0]

shiftY :: Number -> Matrix Number -> Matrix Number
shiftY n = shift [0.0, n, 0.0]

shiftZ :: Number -> Matrix Number -> Matrix Number
shiftZ n = shift [0.0, 0.0, n]
