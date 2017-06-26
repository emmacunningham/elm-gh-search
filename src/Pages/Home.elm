module Pages.Home exposing (..)

import Html exposing (Html, div, text, input)
import Html.Events as Events
import Types exposing (Msg(..))


view : Html Msg
view =
    div []
        [ text "search for users"
        , input [ Events.onInput UpdateSearch ] []
        , div [ Events.onClick SubmitSearch ] [ text "click" ]
        ]
