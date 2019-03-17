module UserUtils
    exposing
        ( userInfo
        , ageAsString
        )

import Model exposing (User)


userInfo : User -> String
userInfo user =
    user.name ++ " (" ++ (ageAsString user) ++ ")"


ageAsString : User -> String
ageAsString user =
    user.age |> Maybe.map toString |> Maybe.withDefault ""
