module Types exposing (..)

import Navigation exposing (Location)


type Route
    = HomeRoute
    | SearchRoute String
    | ReposRoute String


type alias Model =
    { route : Route
    }


type Msg
    = OnLocationChange Location
