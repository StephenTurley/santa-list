module Main exposing (..)

import Browser exposing (sandbox)
import Html exposing (..)
import Html.Attributes exposing (value)
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
    , names : List String
    }



-- Msg


type Msg
    = NameAdded
    | NameToAddChanged String


init : Model
init =
    { nameToAdd = "", names = [] }



-- Update


update : Msg -> Model -> Model
update msg model =
    case msg of
        NameAdded ->
            { model | names = model.names ++ [ model.nameToAdd ], nameToAdd = "" }

        NameToAddChanged name ->
            { model | nameToAdd = name }



-- View


view : Model -> Html Msg
view model =
    div []
        [ namesList model.names
        , input [ onInput NameToAddChanged, value model.nameToAdd ] []
        , button [ onClick NameAdded ] [ text "Save Name" ]
        ]


namesList : List String -> Html Msg
namesList names =
    let
        nameItem : String -> Html Msg
        nameItem name =
            li [] [ text name ]
    in
    ul [] <| List.map nameItem names
