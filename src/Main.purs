module Main where

import Prelude
import Effect (Effect)
import Flare (UI, intSlider)
import Flare.Drawing (runFlareDrawing)
import Graphics.Drawing
import Data.Int (toNumber)
import Color (black)

pointCount :: UI Int
pointCount = intSlider "Point count" 1 100 9

skipSize :: UI Int
skipSize = intSlider "Skip size" 1 100 5

picture :: UI Drawing
picture = (\r -> filled (fillColor black) $ circle 100.0 100.0 $ toNumber r) <$> pointCount

main :: Effect Unit
main = runFlareDrawing "controls" "output" picture
