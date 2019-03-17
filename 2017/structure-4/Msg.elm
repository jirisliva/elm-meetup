module Msg exposing (Msg(..))


type Msg
    = NoOp
    | UserName String
    | UserAge String
    | Save
    | Delete String
    | ProjectMsg String Project.Msg
