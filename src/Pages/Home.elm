module Pages.Home exposing (..)

import Html exposing (Html, div, text, input)
import Html.Events as Events
import Types exposing (Msg(..), Model, Route(..))


view : Model -> Html Msg
view model =
    div []
        [ text "search for users"
        , input [ Events.onInput UpdateSearch ] []
        , div [ Events.onClick (GoTo (UsersRoute model.searchInput)) ] [ text "click" ]
        ]
