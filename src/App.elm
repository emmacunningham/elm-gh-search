module App exposing (..)

import Html exposing (Html, text, div, img)
import Routing exposing (parseLocation)
import Types exposing (Route(..), Model, Msg(..))
import Pages.Home
import Pages.Users
import Pages.Repos
import RemoteData
import Commands as Cmds


initModel : Model
initModel =
    { route = HomeRoute
    , searchInput = ""
    , userResult = RemoteData.Loading
    , repoResult = RemoteData.Loading
    }


getCmd : Model -> Route -> Cmd Msg
getCmd model route =
    case route of
        UsersRoute user ->
            Cmds.fetchUsers user

        ReposRoute user ->
            Cmds.fetchRepos user

        _ ->
            Cmd.none


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        OnLocationChange location ->
            let
                newRoute =
                    parseLocation location
            in
                ( { model | route = newRoute }, getCmd model newRoute )

        UpdateSearch input ->
            ( { model | searchInput = input }, Cmd.none )

        SubmitSearch ->
            ( model, Cmd.none )

        OnFetchUsers response ->
            ( { model | userResult = response }, Cmd.none )

        OnFetchRepos response ->
            ( { model | repoResult = response }, Cmd.none )

        GoTo route ->
            ( { model | route = route }, Routing.goTo route )


view : Model -> Html Msg
view model =
    case model.route of
        HomeRoute ->
            Pages.Home.view model

        UsersRoute _ ->
            Pages.Users.view model

        ReposRoute _ ->
            Pages.Repos.view model


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none
