module Main where

import Prelude

import Control.Monad.Eff (Eff)
import Data.Maybe (Maybe(..))
import Graphics.Canvas (
    CANVAS, rect, fillPath, setFillStyle, getContext2D, getCanvasElementById)
import Partial.Unsafe (unsafePartial)
import DOM (DOM)
import DOM.HTML (window)
import DOM.HTML.Window (requestAnimationFrame)
import Control.Monad.Eff.Console (CONSOLE, log)

main :: Eff (canvas :: CANVAS, console :: CONSOLE, dom :: DOM) Unit
main = void $ unsafePartial do
    Just canvas <- getCanvasElementById "my-canvas"
    ctx <- getContext2D canvas

    _ <- setFillStyle "#0000FF" ctx

    _ <- fillPath ctx $ rect ctx
        {
            x: 250.0,
            y: 250.0,
            w: 100.0,
            h: 100.0
        }

    _ <- log "HERE"

    win <- window

    requestAnimationFrame main win

--
--    requestAnimationFrame tick window
--
--tick :: forall eff. Eff (canvas :: CANVAS | eff) Unit
--tick = do
--    requestAnimationFrame tick window
