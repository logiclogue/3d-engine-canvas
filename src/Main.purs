module Main where

import Prelude

import Effect (Effect)
import Data.Maybe (Maybe(..), fromMaybe)
import Data.Array ((!!))
import Graphics.Canvas (
    Context2D, rect, fillPath, setFillStyle, getContext2D,
    getCanvasElementById, clearRect, moveTo, lineTo, closePath, strokePath,
    beginPath)
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
import Pairs (pairs)
import Data.Tuple (Tuple, fst, snd)

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

drawLinePoints :: Context2D -> Point -> Point -> Effect Unit
drawLinePoints ctx pointA pointB = do
    setFillStyle ctx "#0000FF"
    strokePath ctx $ do
        moveTo ctx pointA.x pointA.y
        lineTo ctx pointB.x pointB.y
        closePath ctx

drawLine :: Context2D -> Tuple (Vector Number) (Vector Number) -> Effect Unit
drawLine ctx tuple = drawLinePoints ctx first second
  where
    first = vectorToPoint (fst tuple)
    second = vectorToPoint (snd tuple)

drawMatrix :: Context2D -> Matrix Number -> Effect Unit
drawMatrix ctx matrix = for_ vectors (drawVector ctx)
  where
    vectors = columns matrix
    allPairs = pairs vectors [0.0, 0.0, 0.0]

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
