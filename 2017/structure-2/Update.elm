module Update exposing (update)

import Model exposing (Model, User)
import Msg exposing (Msg(..))


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
