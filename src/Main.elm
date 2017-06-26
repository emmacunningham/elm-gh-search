module Main exposing (..)

import App exposing (..)


-- import Html exposing (programWithFlags)

import Types exposing (Msg(..), Model, Route(..))
import Navigation exposing (Location)
import Routing


initialModel : Route -> Model
initialModel route =
    case route of
        UsersRoute userName ->
            { initModel | route = route, searchInput = userName }

        _ ->
            { initModel | route = route }


init : Location -> ( Model, Cmd Msg )
init location =
    let
        currentRoute =
            Routing.parseLocation location

        currentModel =
            initialModel currentRoute
    in
        ( currentModel, getCmd currentModel currentRoute )


main : Program Never Model Msg
main =
    Navigation.program OnLocationChange
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
