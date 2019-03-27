module Main exposing (Model, Msg(..), init, main, update)

-- MAIN


main =
    Platform.worker
        { init = init
        , update = update
        , subscriptions = subscriptions
        }


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.none



-- MODEL


type alias Model =
    { greetings : String
    }


init : () -> ( Model, Cmd Msg )
init _ =
    ( Model "Hello World"
    , Cmd.none
    )



-- UPDATE


type Msg
    = NoOp


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    let
        _ =
            Debug.log "hehe!" model
    in
    ( model, Cmd.none )
