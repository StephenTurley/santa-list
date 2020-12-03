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
    | TogglePurchased Person Item


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
                    List.map (updatePerson (addItem item) name) model.people
            in
            { model | people = uPeople, itemToAdd = "" }

        TogglePurchased person item ->
            let
                uPeople =
                    model.people
                        |> List.map (updatePerson (togglePurchased item) person.name)
            in
            { model | people = uPeople }


updatePerson : (Person -> Person) -> String -> Person -> Person
updatePerson updater name person =
    if name == person.name then
        updater person

    else
        person


addItem : Item -> Person -> Person
addItem item person =
    { person | items = person.items ++ [ item ] }


togglePurchased : Item -> Person -> Person
togglePurchased itemToFind person =
    let
        toggleItem =
            \i ->
                if itemToFind.name == i.name then
                    { i | isPurchased = not i.isPurchased }

                else
                    i
    in
    { person | items = List.map toggleItem person.items }



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
        |> List.map (viewItem person)
        |> ul []
    ]


viewItem : Person -> Item -> Html Msg
viewItem person item =
    li [ onClick (TogglePurchased person item) ] [ p [] [ text item.name ] ]
