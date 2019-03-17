module View exposing (view)

import Html exposing (..)
import Html.Events exposing (..)
import Html.Attributes exposing (..)
import Json.Decode as Decode
import Model exposing (Model, User)
import Msg exposing (Msg(..))
import UserUtils exposing (ageAsString, userInfo)


view : Model -> Html Msg
view model =
    div [ commonStyles ]
        [ div []
            [ viewUsers model.users ]
        , div []
            [ input
                [ commonStyles
                , placeholder "Name"
                , onInput UserName
                , value model.user.name
                ]
                []
            , br [] []
            , input
                [ commonStyles
                , placeholder "Age"
                , onInput UserAge
                , onEnter Save
                , value (ageAsString model.user)
                ]
                []
            , button
                [ commonStyles
                , onClick Save
                ]
                [ text "Add" ]
            ]
        ]


viewUsers : List User -> Html Msg
viewUsers users =
    ul [] (List.map (\user -> li [] [ text <| userInfo user ]) users)


onEnter : Msg -> Attribute Msg
onEnter msg =
    let
        tagger code =
            if code == 13 then
                msg
            else
                NoOp
    in
        on "keydown" (Decode.map tagger keyCode)


commonStyles : Attribute msg
commonStyles =
    style
        [ ( "font-family", "PT Sans" )
        , ( "font-size", "40px" )
        , ( "padding", "10px" )
        ]
