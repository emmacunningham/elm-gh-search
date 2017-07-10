module Pages.Home exposing (..)

import Html exposing (Html, div, text, input)
import Html.Events as Events
import Types exposing (Msg(..), Model, Route(..))
import Html.Attributes exposing (class, placeholder)
import Ui


view : Model -> Html Msg
view model =
    div []
        [ text "Search users names: "
        , input [ Events.onInput UpdateSearch, class "input", placeholder "octocat" ] []
        , div [ Events.onClick (GoTo (UsersRoute model.searchInput)), class "btn paper-raise" ] [ text "Submit" ]
        ]
