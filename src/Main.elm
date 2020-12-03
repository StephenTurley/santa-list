module Main exposing (..)

import Browser exposing (sandbox)
import Html exposing (..)
import Html.Attributes exposing (value)
import Html.Events exposing (onClick, onInput)
import Set exposing (Set)



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
    , names : List Person
    , selected : String
    }


type alias Person =
    { name : String
    , items : List String
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
    , selected = ""
    }



-- Update


update : Msg -> Model -> Model
update msg model =
    case msg of
        NameAdded ->
            let
                person name =
                    { name = name, items = [] }
            in
            { model | names = model.names ++ [ person model.nameToAdd ], nameToAdd = "" }

        NameToAddChanged name ->
            { model | nameToAdd = name }

        NameSelected name ->
            { model | selected = name }



-- View


view : Model -> Html Msg
view model =
    div []
        [ namesList model
        , input [ onInput NameToAddChanged, value model.nameToAdd ] []
        , button [ onClick NameAdded ] [ text "Add Name" ]
        ]


namesList : Model -> Html Msg
namesList model =
    model.names
        |> List.map .name
        |> List.map (nameItem model.selected)
        |> ul []


nameItem : String -> String -> Html Msg
nameItem selected name =
    let
        itemInput =
            if name == selected then
                [ input [] []
                , button [] [ text "Add Item" ]
                ]

            else
                []
    in
    li [ onClick (NameSelected name) ]
        ([ p [] [ text name ] ] ++ itemInput)
