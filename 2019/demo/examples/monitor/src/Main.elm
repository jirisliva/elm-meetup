module Main exposing (Model, Msg(..), init, main, update, view)

import Browser
import Html exposing (Html, div, h1, h5, hr, span, text)
import Html.Attributes as Attributes
import Html.Events as Events
import Json.Decode as Decode
import Json.Encode as Encode



-- MAIN


main =
    Browser.element
        { init = init
        , update = update
        , subscriptions = subscriptions
        , view = view
        }



-- MODEL


type alias Model =
    { greetings : String
    }


init : () -> ( Model, Cmd Msg )
init _ =
    ( Model "Hello World", Cmd.none )



-- UPDATE


type Msg
    = NoOp
    | EditorChanged String


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )

        EditorChanged value ->
            ( { model | greetings = value }, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- VIEW


view : Model -> Html Msg
view model =
    div []
        [ h1 [] [ text "custom-editor" ]
        , h5 [] [ text model.greetings ]
        , Html.node "custom-editor"
            [ Attributes.property "editorValue" (Encode.string model.greetings)
            , Events.on "editorChanged" (Decode.map EditorChanged <| Decode.at [ "detail" ] <| Decode.string)
            ]
            []
        , h1 [] [ text "custom-editor2" ]
        , Html.node "custom-editor2"
            [ Attributes.property "editorValue" (Encode.string model.greetings)
            , Events.on "editorChanged" (Decode.map EditorChanged <| Decode.at [ "target", "editorValue" ] <| Decode.string)
            ]
            []
        , div []
            [ hr [] []
            , span [] [ text "footer" ]
            ]
        ]
