module Project exposing (Model, Msg(..), view, update, activate)

import Html exposing (..)
import Html.Events exposing (..)
import Html.Attributes exposing (..)
import Json.Decode as Decode


type alias Model =
    { name : String
    , active : Bool
    }


type Msg
    = ProjectActivity Bool


activate : Model -> Bool -> Model
activate model active =
    { model | active = active }


update : Msg -> Model -> Model
update msg model =
    case msg of
        ProjectActivity active ->
            { model | active = active }


view : Model -> Html Msg
view model =
    div [ projectStyles model ]
        [ div []
            [ viewLabel "Project"
            , viewValue model.name
            ]
        , div []
            [ viewLabel "Active"
            , span []
                [ input
                    [ type_ "checkbox"
                    , onCheck ProjectActivity
                    , checked model.active
                    ]
                    []
                ]
            ]
        ]


projectStyles : Model -> Attribute Msg
projectStyles model =
    style
        [ ( "font-family", "PT Sans" )
        , ( "font-size", "20px" )
        , ( "padding", "10px" )
        , ( "margin", "5px" )
        , ( "width", "300px" )
        , ( "border", "solid #dddddd" )
        , (if model.active then
            ( "background", "#eeffee" )
           else
            ( "background", "silver" )
          )
        ]


viewLabel : String -> Html msg
viewLabel label =
    span
        [ style
            [ ( "width", "40%" )
            , ( "display", "inline-block" )
            ]
        ]
        [ text label ]


viewValue : String -> Html msg
viewValue value =
    span
        [ style
            [ ( "font-weight", "bold" )
            , ( "text-align", "right" )
            , ( "width", "60%" )
            ]
        ]
        [ text value ]
