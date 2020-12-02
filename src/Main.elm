module Main exposing (..)

import Browser exposing (sandbox)
import Html exposing (..)
import Html.Events exposing (onInput)



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



-- Msg


type Msg
    = NameAdded String


init : Model
init =
    "Hello World!"



-- Update


update : Msg -> Model -> Model
update (NameAdded name) model =
    name



-- View


view : Model -> Html Msg
view model =
    div []
        [ p [] [ text model ]
        , input [ onInput NameAdded ] []
        ]
