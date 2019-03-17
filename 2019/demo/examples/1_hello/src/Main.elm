module Main exposing (..)

import Browser
import Html exposing (..)
import Html.Events exposing (..)


-- MAIN


main =
    Browser.sandbox
        { init = init
        , update = update
        , view = view
        }



-- MODEL


type alias Model =
    { greetings : String
    }


init : Model
init =
    Model "Hello World"



-- UPDATE


type Msg
    = NoOp


update : Msg -> Model -> Model
update msg model =
    model



-- VIEW


view : Model -> Html Msg
view model =
    div []
        [ h1 [] [ text model.greetings ]
        ]
