module TransformationMatrices where

import Prelude
import LinearAlgebra.Matrix (Matrix)
import Math (sin, cos)
import MatrixHelpers (toTransformationMatrix)

projectionMatrix :: Matrix Number
projectionMatrix = toTransformationMatrix [
    1.0, 0.0, 0.0,
    0.0, 1.0, 0.0,
    0.0, 0.0, 0.0]

xRotationMatrix :: Number -> Matrix Number
xRotationMatrix angle = toTransformationMatrix [
    1.0, 0.0, 0.0,
    0.0, cos angle, sin angle,
    0.0, -sin angle, cos angle]

yRotationMatrix :: Number -> Matrix Number
yRotationMatrix angle = toTransformationMatrix [
    cos angle, 0.0, -sin angle,
    0.0, 1.0, 0.0,
    sin angle, 0.0, cos angle]

zRotationMatrix :: Number -> Matrix Number
zRotationMatrix angle = toTransformationMatrix [
    cos angle, sin angle, 0.0,
    -sin angle, cos angle, 0.0,
    0.0, 0.0, 1.0]

scaleMatrix :: Number -> Matrix Number
scaleMatrix factor = toTransformationMatrix [
    factor, 0.0, 0.0,
    0.0, factor, 0.0,
    0.0, 0.0, factor]
