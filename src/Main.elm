module Main exposing (..)

import App exposing (..)


-- import Html exposing (programWithFlags)

import Types exposing (Msg(..), Model, Route)
import Navigation exposing (Location)
import Routing


initialModel : Route -> Model
initialModel route =
    { initModel | route = route }


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
