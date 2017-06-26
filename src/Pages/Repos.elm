module Pages.Repos exposing (..)

import Html exposing (Html, div, text, input)
import Html.Events as Events
import Types exposing (Msg(..), Model)


view : Model -> Html Msg
view model =
    div []
        [ text "search for users"
        , input [ Events.onInput UpdateSearch ] []
        , div [ Events.onClick SubmitSearch ] [ text "click" ]
        ]
