module InnerFlare where

import Data.List (List(..))
import Data.NonEmpty (NonEmpty, (:|))
import Effect (Effect)
import Flare (UI, select, runFlareShow, innerFlare, intSlider, intRange)
import Prelude

main :: Effect Unit
main = runFlareShow "controls" "output" ui

ui :: UI Int
ui =
    innerFlare
    (select "Pick input method" inputOptions show)
    (\inputControl -> case inputControl of
        Slider  -> intSlider (show inputControl) 1 10 5
        TextBox -> intRange  (show inputControl) 1 10 5)

inputOptions :: NonEmpty List InputControl
inputOptions = Slider :| Cons TextBox Nil

data InputControl = Slider | TextBox

instance showInputControl :: Show InputControl where
  show Slider = "Slider"
  show TextBox = "Text Box"
