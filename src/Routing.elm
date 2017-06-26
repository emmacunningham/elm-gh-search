module Routing exposing (..)

import Navigation exposing (Location)
import UrlParser exposing (..)
import Types exposing (Route(..))


matchers : Parser (Route -> a) a
matchers =
    oneOf
        [ map HomeRoute top
        , map UsersRoute (s "users" </> string)
        , map ReposRoute (s "repos" </> string)
        ]


parseLocation : Location -> Route
parseLocation location =
    case (parseHash matchers location) of
        Just route ->
            route

        Nothing ->
            HomeRoute


goTo : Route -> Cmd msg
goTo route =
    case route of
        HomeRoute ->
            Navigation.newUrl "/"

        UsersRoute searchTerm ->
            Navigation.newUrl ("/users/" ++ searchTerm)

        ReposRoute username ->
            Navigation.newUrl ("/repos/" ++ username)
