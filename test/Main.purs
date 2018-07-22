module Test.Main where

import Prelude
import Effect (Effect)
import Effect.Class.Console (log)

main :: forall e. Eff (console :: CONSOLE | e) Unit
main = do
  log "You should add some tests."
