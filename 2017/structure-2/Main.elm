module Main exposing (..)

import Html
import Model exposing (Model, model)
import Msg exposing (Msg(..))
import View exposing (view)
import Update exposing (update)


main : Program Never Model Msg
main =
    Html.beginnerProgram
        { model = model
        , view = view
        , update = update
        }
