module Main exposing (Model, Msg(..), init, main, update, view)

import Browser
import Counter
import Html exposing (..)


main =
    Browser.sandbox
        { init = init
        , update = update
        , view = view
        }


type alias Model =
    { greetings : String
    , counter : Counter.Model
    }


init : Model
init =
    Model "Hello World" Counter.init


type Msg
    = NoOp
    | CounterMsg Counter.Msg


update : Msg -> Model -> Model
update msg model =
    case msg of
        NoOp ->
            model

        CounterMsg subMsg ->
            { model | counter = Counter.update subMsg model.counter }


view : Model -> Html Msg
view model =
    div []
        [ h1 [] [ text model.greetings ]
        , Html.map CounterMsg (Counter.view model.counter)
        ]
