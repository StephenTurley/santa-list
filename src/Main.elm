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
    , selected : Maybe String
    }



-- Msg


type Msg
    = NameAdded
    | NameToAddChanged String
    | NameSelected String


init : Model
init =
    { nameToAdd = ""
    , names = []
    , selected = Nothing
    }



-- Update


update : Msg -> Model -> Model
update msg model =
    case msg of
        NameAdded ->
            { model | names = model.names ++ [ model.nameToAdd ], nameToAdd = "" }

        NameToAddChanged name ->
            { model | nameToAdd = name }

        NameSelected name ->
            { model | selected = Just name }



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
            li [ onClick (NameSelected name) ] [ text name ]
    in
    ul [] <| List.map nameItem names
