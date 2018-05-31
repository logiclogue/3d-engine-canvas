module Camera where

import Prelude

import LinearAlgebra.Vector (Vector)

type Camera = {
    position :: Vector Number
    rotation :: Vector Number
}
