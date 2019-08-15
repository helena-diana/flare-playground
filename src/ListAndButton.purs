module ListAndButton where

import Prelude
import Data.Array (cons)
import Data.Foldable (foldMap)
import Effect (Effect)
import Flare (UI, button, foldp, string, (<**>))
import Flare.Smolder (runFlareHTML)
import Text.Smolder.HTML (Html, li, ul) as H
import Text.Smolder.Markup (text) as H

main :: Effect Unit
main = runFlareHTML "controls" "output" ui

actions :: UI (Array String -> Array String)
actions = string "Add item:" "Orange" <**> button "Add" (flip const) cons

list :: UI (Array String)
list = foldp identity ["Apple", "Banana"] actions

ui :: forall a. UI (H.Html a)
ui = (\items -> H.ul $ foldMap (H.li <<< H.text) items) <$> list
