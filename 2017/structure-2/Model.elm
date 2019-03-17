module Model exposing (..)


type alias Model =
    { user : User
    , users : List User
    }


type alias User =
    { name : String
    , age : Maybe Int
    }


model : Model
model =
    { user = User "" Nothing
    , users = []
    }
