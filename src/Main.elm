module Main exposing (..)

import Browser exposing (sandbox)
import Html exposing (..)


main =
    Browser.sandbox
        { init = "Hello World"
        , update = \msg model -> model
        , view = view
        }


view model =
    h1 [] [ text model ]
