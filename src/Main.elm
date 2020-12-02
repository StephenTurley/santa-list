module Main exposing (..)

import Browser exposing (sandbox)
import Html exposing (..)
import Html.Events exposing (onClick, onInput)



-- Main


main =
    Browser.sandbox
        { init = init
        , update = update
        , view = view
        }



-- Model


type alias Model =
    { nameToAdd : String
    , name : String
    }



-- Msg


type Msg
    = NameAdded
    | NameToAddChanged String


init : Model
init =
    { nameToAdd = "", name = "" }



-- Update


update : Msg -> Model -> Model
update msg model =
    case msg of
        NameAdded ->
            { model | name = model.nameToAdd }

        NameToAddChanged name ->
            { model | nameToAdd = name }



-- View


view : Model -> Html Msg
view model =
    div []
        [ p [] [ text model.name ]
        , input [ onInput NameToAddChanged ] []
        , button [ onClick NameAdded ] [ text "Save Name" ]
        ]
