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
    { people : List String
    , nameToAdd : String
    }


init : Model
init =
    { people = []
    , nameToAdd = ""
    }



-- Msg


type Msg
    = NameToAddChanged String
    | AddPerson



-- Update


update : Msg -> Model -> Model
update msg model =
    case msg of
        NameToAddChanged name ->
            { model | nameToAdd = name }

        AddPerson ->
            { model | people = model.people ++ [ model.nameToAdd ], nameToAdd = "" }



-- View


view : Model -> Html Msg
view model =
    div []
        [ ul [] (List.map (\p -> li [] [ text p ]) model.people)
        , input [ value model.nameToAdd, onInput NameToAddChanged ] []
        , button [ onClick AddPerson ] [ text "Add Person" ]
        ]
