module Transformable (
    class Transformable, rotateX, rotateY, rotateZ, scale, shift) where

import Prelude (($))
import TransformationMatrices (
    xRotationMatrix, yRotationMatrix, zRotationMatrix, scaleMatrix)
import MatrixHelpers (mapColumns)
import LinearAlgebra.Matrix (Matrix, multiply)
import LinearAlgebra.Vector (add) as Vector
import LinearAlgebra.Vector (Vector)
import Data.Newtype (class Newtype, wrap, unwrap)

class Transformable a where
    rotateX :: Number -> a -> a
    rotateY :: Number -> a -> a
    rotateZ :: Number -> a -> a
    scale :: Number -> a -> a
    shift :: Vector Number -> a -> a

--instance transformableMatrixNumber :: Transformable (Matrix Number) where
--    rotateX angle m = xRotationMatrix angle `multiply` m
--    rotateY angle m = yRotationMatrix angle `multiply` m
--    rotateZ angle m = zRotationMatrix angle `multiply` m
--    scale factor m = scaleMatrix factor `multiply` m
--    shift vector m = mapColumns (\v -> Vector.add v vector) m

instance transformableNewtypeMatrixNumber :: Newtype a (Matrix Number) => Transformable a where
    rotateX angle m = wrap $ xRotationMatrix angle `multiply` (unwrap m)
    rotateY angle m = wrap $ yRotationMatrix angle `multiply` (unwrap m)
    rotateZ angle m = wrap $ zRotationMatrix angle `multiply` (unwrap m)
    scale factor m = wrap $ scaleMatrix factor `multiply` (unwrap m)
    shift vector m = wrap $ mapColumns (\v -> Vector.add v vector) (unwrap m)
