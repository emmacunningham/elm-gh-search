module App exposing (..)

import Html exposing (Html, text, div, img)
import Routing exposing (parseLocation)
import Types exposing (Route(..), Model, Msg(..))
import Pages.Home


init : String -> ( Model, Cmd Msg )
init path =
    ( { route = HomeRoute }, Cmd.none )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        OnLocationChange location ->
            let
                newRoute =
                    parseLocation location
            in
                ( { model | route = newRoute }, Cmd.none )


view : Model -> Html Msg
view model =
    case model.route of
        _ ->
            Pages.Home.view


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none
