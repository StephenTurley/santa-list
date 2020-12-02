module Main exposing (..)

import Browser exposing (sandbox)
import Html exposing (..)



-- Main


main =
    Browser.sandbox
        { init = init
        , update = update
        , view = view
        }



-- Model


type alias Model =
    String


init : Model
init =
    "Hello World!"



-- Update


update : msg -> Model -> Model
update msg model =
    model



-- View


view : Model -> Html msg
view model =
    h1 [] [ text model ]
