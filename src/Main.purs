module Main where

import Prelude

import Control.Monad.Eff (Eff)
import Data.Maybe (Maybe(..), fromMaybe)
import Data.Array ((!!), length)
import Graphics.Canvas (
    CANVAS, Context2D, rect, fillPath, setFillStyle, getContext2D,
    getCanvasElementById, clearRect)
import Partial.Unsafe (unsafePartial)
import DOM (DOM)
import DOM.HTML (window)
import DOM.HTML.Window (requestAnimationFrame)
import Control.Monad.Eff.Console (CONSOLE)
import Data.Int (toNumber)
import LinearAlgebra.Matrix (Matrix, fromArray, zeros, transpose, columns, rows, multiply)
import LinearAlgebra.Vector (Vector)
import Math (sin, cos)
import Data.Foldable (for_, foldr)
import Data.Semigroup ((<>))

type Point = {
    x :: Number,
    y :: Number
}

main :: Eff (canvas :: CANVAS, console :: CONSOLE, dom :: DOM) Unit
main = void $ unsafePartial do
    Just canvas <- getCanvasElementById "my-canvas"
    ctx <- getContext2D canvas

    tick ctx 0

drawPoint :: forall eff. Context2D -> Point -> Eff (canvas :: CANVAS | eff) Context2D
drawPoint ctx point = do
    _ <- setFillStyle "#0000FF" ctx

    fillPath ctx $ rect ctx
        {
            x: point.x,
            y: point.y,
            w: 5.0,
            h: 5.0
        }

toMatrix :: Int -> Int -> Array Number -> Matrix Number
toMatrix r c = fromMaybe (zeros r c) <<< fromArray r c

toTransformationMatrix :: Array Number -> Matrix Number
toTransformationMatrix = toMatrix 3 3

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

scaleMatrix :: Number -> Matrix Number
scaleMatrix factor = toTransformationMatrix [
    factor, 0.0, 0.0,
    0.0, factor, 0.0,
    0.0, 0.0, factor]

cube :: Matrix Number
cube = (transpose <<< (toMatrix 8 3)) [
    0.0, 0.0, 0.0,
    0.0, 0.0, 1.0,
    0.0, 1.0, 0.0,
    0.0, 1.0, 1.0,
    1.0, 0.0, 0.0,
    1.0, 0.0, 1.0,
    1.0, 1.0, 0.0,
    1.0, 1.0, 1.0]

vectorToPoint :: Vector Number -> Point
vectorToPoint vector =
    {
        x: fromMaybe 0.0 (vector !! 0),
        y: fromMaybe 0.0 (vector !! 1)
    }

drawVector :: forall eff. Context2D -> Vector Number -> Eff (canvas :: CANVAS | eff) Context2D
drawVector ctx = drawPoint ctx <<< vectorToPoint

drawMatrix :: forall eff. Context2D -> Matrix Number -> Eff (canvas :: CANVAS | eff) Unit
drawMatrix ctx matrix = for_ vectors (drawVector ctx) where
    vectors = columns matrix

mapColumns :: forall a b. (Vector a -> Vector b -> Vector b) -> Matrix a -> Matrix b
mapColumns f m = fromMaybe m $ fromArray x y array where
    array = foldr (<>) [] (map f xs)
    xs = columns m
    x = length xs
    y = length (rows m)

tick :: forall eff. Context2D -> Int -> Eff (canvas :: CANVAS, dom :: DOM | eff) Unit
tick ctx x = void do
    _ <- clearRect ctx $
        {
            x: 0.0,
            y: 0.0,
            w: 500.0,
            h: 500.0
        }

    _ <- drawMatrix ctx (foldr multiply cube [yRotationMatrix (toNumber x / 30.0), xRotationMatrix (toNumber x / 30.0), scaleMatrix 100.0])

    win <- window

    requestAnimationFrame (tick ctx (x + 1)) win
