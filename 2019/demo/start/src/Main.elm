module Main exposing (Model, Msg(..), init, main, update, view)

import Browser
import Html exposing (..)


main =
    Browser.sandbox
        { init = init
        , update = update
        , view = view
        }


type alias Model =
    { greetings : String
    }


init : Model
init =
    Model "Hello World"


type Msg
    = NoOp


update : Msg -> Model -> Model
update msg model =
    model


view : Model -> Html Msg
view model =
    div []
        [ h1 [] [ text model.greetings ]
        ]
