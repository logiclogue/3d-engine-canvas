module Main where

import Prelude

import Control.Monad.Eff (Eff)
import Data.Maybe (Maybe(..))
import Graphics.Canvas (
    CANVAS, rect, fillPath, setFillStyle, getContext2D, getCanvasElementById)
import Partial.Unsafe (unsafePartial)
import DOM.HTML (window)
import DOM.HTML.Window (requestAnimationFrame)

main :: Eff (canvas :: CANVAS) Unit
main = void $ unsafePartial do
    Just canvas <- getCanvasElementById "my-canvas"
    ctx <- getContext2D canvas

    _ <- setFillStyle "#0000FF" ctx

    fillPath ctx $ rect ctx
        {
            x: 250.0,
            y: 250.0,
            w: 100.0,
            h: 100.0
        }
