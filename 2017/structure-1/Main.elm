module Main exposing (..)

import Html exposing (..)
import Html.Events exposing (..)
import Html.Attributes exposing (..)
import Json.Decode as Decode


main : Program Never Model Msg
main =
    Html.beginnerProgram
        { model = model
        , view = view
        , update = update
        }


type alias XX =
    { x : String
    , y : Int
    }



-- MODEL


type alias Model =
    { user : User
    , users : List User
    }


model : Model
model =
    { user = User "" Nothing
    , users = []
    }


type alias User =
    { name : String
    , age : Maybe Int
    }


userInfo : User -> String
userInfo user =
    user.name ++ " (" ++ (ageAsString user) ++ ")"


ageAsString : User -> String
ageAsString user =
    user.age |> Maybe.map toString |> Maybe.withDefault ""



-- UPDATE


type Msg
    = NoOp
    | UserName String
    | UserAge String
    | Save


update : Msg -> Model -> Model
update msg model =
    case msg of
        NoOp ->
            model

        UserName name ->
            let
                user =
                    model.user
            in
                { model | user = { user | name = name } }

        UserAge age ->
            let
                user =
                    model.user

                ageAsInt =
                    case String.toInt age of
                        Ok value ->
                            Just value

                        Err error ->
                            Nothing
            in
                { model | user = { user | age = ageAsInt } }

        Save ->
            let
                users =
                    model.users

                user =
                    model.user
            in
                { model
                    | users = model.user :: model.users
                    , user =
                        { user
                            | name = ""
                            , age = Nothing
                        }
                }



-- VIEW


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
