module Main exposing (..)

import App exposing (..)


-- import Html exposing (programWithFlags)

import Types exposing (Msg(..), Model, Route)
import Navigation exposing (Location)
import Routing


-- main : Program String Model Msg
-- main =
--     programWithFlags { view = view, init = init, update = update, subscriptions = subscriptions }


initialModel : Route -> Model
initialModel route =
    { route = route
    }


init : Location -> ( Model, Cmd Msg )
init location =
    let
        currentRoute =
            Routing.parseLocation location
    in
        ( initialModel currentRoute, Cmd.none )


main : Program Never Model Msg
main =
    Navigation.program OnLocationChange
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
