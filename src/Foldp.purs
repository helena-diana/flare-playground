module Foldp where

import Effect (Effect)
import Flare (UI, buttons, foldp, runFlareShow)
import Prelude
import Data.Maybe (Maybe(..))

main :: Effect Unit
main = runFlareShow "controls" "output" ui

ui :: UI Int
ui = foldp (\action x -> case action of
    Just Increment -> x+1
    Just Decrement -> x-1
    Nothing -> x) 0 $ buttons [Increment, Decrement] show

data Action = Increment | Decrement

instance showAction :: Show Action where
  show Increment = "+"
  show Decrement = "-"
