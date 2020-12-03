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
    , itemToAdd : String
    , people : List Person
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
    | ItemToAddChanged String
    | ItemAdded String


init : Model
init =
    { nameToAdd = ""
    , itemToAdd = ""
    , people = []
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
            { model | people = model.people ++ [ person model.nameToAdd ], nameToAdd = "" }

        NameToAddChanged name ->
            { model | nameToAdd = name }

        NameSelected name ->
            { model | selected = name }

        ItemToAddChanged item ->
            { model | itemToAdd = item }

        ItemAdded name ->
            let
                uPeople =
                    List.map (addItem name model.itemToAdd) model.people
            in
            { model | people = uPeople, itemToAdd = "" }


addItem : String -> String -> Person -> Person
addItem name item person =
    if name == person.name then
        { person | items = person.items ++ [ item ] }

    else
        person



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
    model.people
        |> List.map .name
        |> List.map (nameItem model)
        |> ul []


nameItem : Model -> String -> Html Msg
nameItem model name =
    let
        itemInput =
            if name == model.selected then
                [ input [ value model.itemToAdd, onInput ItemToAddChanged ] []
                , button [ onClick (ItemAdded name) ] [ text "Add Item" ]
                ]

            else
                []
    in
    li [ onClick (NameSelected name) ]
        ([ p [] [ text name ] ] ++ itemInput)
