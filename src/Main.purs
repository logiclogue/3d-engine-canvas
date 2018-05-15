module Main where

import Prelude

import Control.Monad.Eff (Eff)
import Data.Maybe (Maybe(..))
import Graphics.Canvas (
    CANVAS, Context2D, rect, fillPath, setFillStyle, getContext2D,
    getCanvasElementById)
import Partial.Unsafe (unsafePartial)
import DOM (DOM)
import DOM.HTML (window)
import DOM.HTML.Window (requestAnimationFrame)
import Control.Monad.Eff.Console (CONSOLE, log)
import Data.Int (toNumber)

main :: Eff (canvas :: CANVAS, console :: CONSOLE, dom :: DOM) Unit
main = void $ unsafePartial do
    Just canvas <- getCanvasElementById "my-canvas"
    ctx <- getContext2D canvas

    _ <- setFillStyle "#0000FF" ctx

    tick ctx 0

tick :: forall eff. Context2D -> Int -> Eff (canvas :: CANVAS, dom :: DOM | eff) Unit
tick ctx x = void do
    _ <- fillPath ctx $ rect ctx
        {
            x: (toNumber x),
            y: 250.0,
            w: 100.0,
            h: 100.0
        }

    win <- window

    requestAnimationFrame (tick ctx (x + 1)) win
