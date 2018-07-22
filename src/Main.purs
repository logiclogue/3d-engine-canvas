module Main where

import Prelude

import Effect (Effect)
import Data.Maybe (Maybe(..), fromMaybe)
import Data.Array ((!!))
import Graphics.Canvas (
    Context2D, rect, fillPath, setFillStyle, getContext2D,
    getCanvasElementById, clearRect)
import Partial.Unsafe (unsafePartial)
import Web.HTML (window)
import Web.HTML.Window (requestAnimationFrame)
import Effect.Class.Console (log)
import Data.Int (toNumber)
import LinearAlgebra.Matrix (Matrix, columns)
import LinearAlgebra.Vector (Vector)
import Data.Foldable (for_)
import Renderable (toMatrix)
import Transformable (rotateX, rotateY, scale, shift)
import Cube (Cube, createCube)
import Pyramid (Pyramid, createPyramid)

type Point = {
    x :: Number,
    y :: Number
}

main :: Effect Unit
main = void $ unsafePartial do
    Just canvas <- getCanvasElementById "my-canvas"
    ctx <- getContext2D canvas
    _ <- log "HERE"

    tick ctx 0

drawPoint :: Context2D -> Point -> Effect Unit
drawPoint ctx point = do
    _ <- setFillStyle ctx "#0000FF"

    fillPath ctx $ rect ctx {
        x: point.x,
        y: point.y,
        width: 5.0,
        height: 5.0
    }

cube :: Cube
cube = createCube 1.0 1.0 1.0

pyramid :: Pyramid
pyramid = createPyramid 1.0 1.0 1.0

vectorToPoint :: Vector Number -> Point
vectorToPoint vector =
    {
        x: fromMaybe 0.0 (vector !! 0),
        y: fromMaybe 0.0 (vector !! 1)
    }

drawVector :: Context2D -> Vector Number -> Effect Unit
drawVector ctx = drawPoint ctx <<< vectorToPoint

drawMatrix :: Context2D -> Matrix Number -> Effect Unit
drawMatrix ctx matrix = for_ vectors (drawVector ctx) where
    vectors = columns matrix

tick :: Context2D -> Int -> Effect Unit
tick ctx x = void do
    _ <- clearRect ctx $ {
        x: 0.0,
        y: 0.0,
        width: 500.0,
        height: 500.0
    }

    _ <- drawMatrix ctx $ toMatrix $ (
        scale 100.0 <<<
        shift [1.0, 1.0, 0.0] <<<
        rotateY (toNumber x / 30.0) <<<
        rotateX (toNumber x / 30.0) <<<
        shift [-0.5, -0.5, -0.5]
    ) cube

    win <- window

    requestAnimationFrame (tick ctx (x + 1)) win
