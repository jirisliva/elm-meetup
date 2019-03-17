module Main exposing (..)

import Html exposing (..)
import Html.Events exposing (..)
import Html.Attributes exposing (..)
import Json.Decode as Decode


main =
    Html.beginnerProgram
        { model = model
        , view = view
        , update = update
        }



-- MODEL


model : Model
model =
    { user = User "" Nothing
    , users =
        [ User "Alexandros Megas" (Just 33)
        , User "Seleukos" (Just 41)
        , User "Ptolemaios" (Just 56)
        , User "Lysimachos" (Just 45)
        ]
    , projects =
        [ Project "Conquer Persia" False
        , Project "Conquer Aegyptus" False
        ]
    }


type alias Model =
    { user : User
    , users : List User
    , projects : List Project
    }


type alias User =
    { name : String
    , age : Maybe Int
    }


type alias Project =
    { name : String
    , active : Bool
    }


userInfo : User -> String
userInfo user =
    user.name ++ " (" ++ (ageAsString user) ++ ")"


ageAsString : User -> String
ageAsString user =
    user.age |> Maybe.map toString |> Maybe.withDefault ""


findUser : String -> List User -> Maybe User
findUser name users =
    users
        |> List.filter (\user -> user.name == name)
        |> List.head


deleteUser : String -> List User -> List User
deleteUser name users =
    users
        |> List.filter (\user -> user.name /= name)



-- UPDATE


type Msg
    = NoOp
    | UserName String
    | UserAge String
    | Save
    | Delete String
    | ProjectActivity String Bool


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

        Delete name ->
            { model | users = deleteUser name model.users }

        ProjectActivity name active ->
            let
                projects =
                    List.map
                        (\project ->
                            if project.name == name then
                                { project | active = active }
                            else
                                project
                        )
                        model.projects
            in
                { model | projects = projects }



-- VIEW


view : Model -> Html Msg
view model =
    div [ commonStyles ]
        [ viewForm model
        , viewUsers model.users
        , viewProjects model.projects
        ]


viewForm : Model -> Html Msg
viewForm model =
    div []
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


viewProjects : List Project -> Html Msg
viewProjects projects =
    div []
        (List.map
            (\project -> viewProject project)
            projects
        )


viewProject : Project -> Html Msg
viewProject project =
    div [ projectStyles project ]
        [ div []
            [ viewLabel "Project"
            , viewValue project.name
            ]
        , div []
            [ viewLabel "Active"
            , span []
                [ input
                    [ type_ "checkbox"
                    , onCheck (ProjectActivity project.name)
                    , checked project.active
                    ]
                    []
                ]
            ]
        ]


viewUsers : List User -> Html Msg
viewUsers users =
    div [] (List.map (\user -> viewUser user) users)


viewUser : User -> Html Msg
viewUser user =
    div [ userStyles ]
        [ div []
            [ viewLabel "Name"
            , viewValue user.name
            ]
        , div []
            [ viewLabel "Age"
            , viewValue (ageAsString user)
            ]
        , div []
            [ button [ onClick (Delete user.name) ] [ text "DELETE" ]
            ]
        ]


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


commonStyles : Attribute Msg
commonStyles =
    style
        [ ( "font-family", "PT Sans" )
        , ( "font-size", "20px" )
        , ( "padding", "10px" )
        ]


userStyles : Attribute Msg
userStyles =
    style
        [ ( "font-family", "PT Sans" )
        , ( "font-size", "20px" )
        , ( "padding", "10px" )
        , ( "margin", "5px" )
        , ( "width", "300px" )
        , ( "border", "solid #dddddd" )
        ]


projectStyles : Project -> Attribute Msg
projectStyles project =
    style
        [ ( "font-family", "PT Sans" )
        , ( "font-size", "20px" )
        , ( "padding", "10px" )
        , ( "margin", "5px" )
        , ( "width", "300px" )
        , ( "border", "solid #dddddd" )
        , (if project.active then
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
