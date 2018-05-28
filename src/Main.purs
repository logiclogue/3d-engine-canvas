module Main where

import Prelude

import Control.Monad.Eff (Eff)
import Data.Maybe (Maybe(..), fromMaybe)
import Data.Array ((!!))
import Graphics.Canvas (
    CANVAS, Context2D, rect, fillPath, setFillStyle, getContext2D,
    getCanvasElementById, clearRect)
import Partial.Unsafe (unsafePartial)
import DOM (DOM)
import DOM.HTML (window)
import DOM.HTML.Window (requestAnimationFrame)
import Control.Monad.Eff.Console (CONSOLE)
import Data.Int (toNumber)
import LinearAlgebra.Matrix (Matrix, transpose, columns, multiply)
import LinearAlgebra.Vector (Vector)
import Data.Foldable (for_, foldr)
import MatrixHelpers (toMatrix)
import TransformationMatrices (yRotationMatrix, xRotationMatrix, scaleMatrix)

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

tick :: forall eff. Context2D -> Int -> Eff (canvas :: CANVAS, dom :: DOM | eff) Unit
tick ctx x = void do
    _ <- clearRect ctx $
        {
            x: 0.0,
            y: 0.0,
            w: 500.0,
            h: 500.0
        }

    _ <- drawMatrix ctx $ foldr multiply cube [yRotationMatrix (toNumber x / 30.0), xRotationMatrix (toNumber x / 30.0), scaleMatrix 100.0]

    win <- window

    requestAnimationFrame (tick ctx (x + 1)) win
