module Main where

import Color as Color
import Control.Apply (lift2)
import Data.Array ((..), index, mapMaybe)
import Data.Foldable (fold)
import Data.FoldableWithIndex (foldMapWithIndex)
import Data.Int (toNumber)
import Effect (Effect)
import Flare (UI, intRange)
import Flare.Drawing (runFlareDrawing)
import Graphics.Drawing (Color, Drawing, Point, circle, closed, fillColor, filled, lineWidth, outlined, text, translate)
import Graphics.Drawing.Font (Font, font, serif)
import Math (cos, pi, sin)
import Prelude

main :: Effect Unit
main = runFlareDrawing "controls" "output" skippedStar

pointCount :: UI Int
pointCount = intRange "Point count" 3 30 7

skipSize :: UI Int
skipSize = intRange "Skip size" 1 30 3

skippedStar :: UI Drawing
skippedStar =
    lift2 (\pc ss ->
        let radius = 200.0
            stroke = outlined (lineWidth 2.0)
            points = pointsAroundCircle pc radius
            skippedIndices = map (\i -> (ss * i) `mod` pc) $ 0 .. (pc - 1)
            skippedPoints = mapMaybe (index points) skippedIndices
        in translate 250.0 250.0 $ fold
            [ stroke $ closed skippedPoints
            , stroke $ circle 0.0 0.0 radius
            , foldMapWithIndex labeledRedPoint points
            ]
    ) pointCount skipSize


labeledRedPoint :: Int -> Point -> Drawing
labeledRedPoint i {x,y} = fold
    [ circle x y 4.0 # filled (fillColor red)
    , text myFont (1.1 * x) (1.1 * y) mempty (show i) # translate (-5.0) (10.0)
    ]

pointsAroundCircle :: Int -> Number -> Array Point
pointsAroundCircle pointCnt radius =
    map mkPoint angles
  where
    ns = 0 .. (pointCnt - 1)
    angles = map (\i -> toNumber i * 2.0 * pi / toNumber pointCnt - pi / 2.0) ns
    mkPoint angle =
        { x: radius * cos angle
        , y: radius * sin angle
        }

red :: Color
red = Color.rgb 255 0 0

myFont :: Font
myFont = font serif 20 mempty
