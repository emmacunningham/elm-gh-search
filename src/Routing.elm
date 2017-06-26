module Routing exposing (..)

import Navigation exposing (Location)
import UrlParser exposing (..)
import Types exposing (Route(..))


matchers : Parser (Route -> a) a
matchers =
    oneOf
        [ map HomeRoute top
        , map SearchRoute (s "search" </> string)
        , map ReposRoute (s "repos" </> string)
        ]


parseLocation : Location -> Route
parseLocation location =
    case (parseHash matchers location) of
        Just route ->
            route

        Nothing ->
            HomeRoute
