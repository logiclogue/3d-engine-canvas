module Transformable (
    class Transformable, rotateX, rotateY, rotateZ, scale, shift) where

import LinearAlgebra.Vector (Vector)

class Transformable a where
    rotateX :: Number -> a -> a
    rotateY :: Number -> a -> a
    rotateZ :: Number -> a -> a
    scale :: Number -> a -> a
    shift :: Vector Number -> a -> a
