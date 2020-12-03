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
    , items : List Item
    }


type alias Item =
    { name : String
    , isPurchased : Bool
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
                item =
                    { name = model.itemToAdd, isPurchased = False }

                uPeople =
                    List.map (addItem name item) model.people
            in
            { model | people = uPeople, itemToAdd = "" }


addItem : String -> Item -> Person -> Person
addItem name item person =
    if name == person.name then
        { person | items = person.items ++ [ item ] }

    else
        person



-- View


view : Model -> Html Msg
view model =
    div []
        [ viewNamesList model
        , input [ onInput NameToAddChanged, value model.nameToAdd ] []
        , button [ onClick NameAdded ] [ text "Add Name" ]
        ]


viewNamesList : Model -> Html Msg
viewNamesList model =
    model.people
        |> List.map (viewName model)
        |> ul []


viewName : Model -> Person -> Html Msg
viewName model person =
    li [ onClick (NameSelected person.name) ]
        ([ p [] [ text person.name ] ] ++ viewItems person ++ viewItemInput model person)


viewItemInput : Model -> Person -> List (Html Msg)
viewItemInput model person =
    if person.name == model.selected then
        [ input [ value model.itemToAdd, onInput ItemToAddChanged ] []
        , button [ onClick (ItemAdded person.name) ] [ text "Add Item" ]
        ]

    else
        []


viewItems : Person -> List (Html Msg)
viewItems person =
    [ person.items
        |> List.map .name
        |> List.map viewItem
        |> ul []
    ]


viewItem : String -> Html Msg
viewItem item =
    li [] [ p [] [ text item ] ]
