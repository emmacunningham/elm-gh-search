module App exposing (..)

import Html exposing (Html, text, div, img)
import Routing exposing (parseLocation)
import Types exposing (Route(..), Model, Msg(..))
import Pages.Home
import RemoteData
import Commands as Cmds


initModel : Model
initModel =
    { route = HomeRoute
    , searchInput = ""
    , userResult = RemoteData.Loading
    }


init : String -> ( Model, Cmd Msg )
init path =
    ( initModel, Cmd.none )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        OnLocationChange location ->
            let
                newRoute =
                    parseLocation location
            in
                ( { model | route = newRoute }, Cmd.none )

        UpdateSearch input ->
            ( { model | searchInput = input }, Cmd.none )

        SubmitSearch ->
            ( model, Cmds.fetchUsers model.searchInput )

        OnFetchUsers response ->
            ( { model | userResult = response }, Cmd.none )



-- _ ->
--     ( model, Cmd.none )


view : Model -> Html Msg
view model =
    case model.route of
        _ ->
            Pages.Home.view


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none
