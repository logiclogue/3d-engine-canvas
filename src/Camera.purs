module Camera where

import LinearAlgebra.Vector (Vector)

type Camera = {
    position :: Vector Number,
    rotation :: Vector Number
}
