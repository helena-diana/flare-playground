{-
Welcome to a Spago project!
You can edit this file as you like.
-}
{ name =
    "flare-playground"
, dependencies =
    [ "effect", "console", "psci-support" , "flare" ]
, packages =
    ./packages.dhall
, sources =
    [ "src/**/*.purs", "test/**/*.purs" ]
}
