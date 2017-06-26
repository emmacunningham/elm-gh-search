module Pages.Users exposing (..)

import Html exposing (Html, div, text, input, img)
import Html.Events as Events
import Html.Attributes as Attributes
import Types exposing (Msg(..), Model, UserResult, User, Route(..))
import RemoteData exposing (WebData)


viewUser : User -> Html Msg
viewUser user =
    div [] [ img [ Attributes.src user.avatar_url, Events.onClick (GoTo (ReposRoute user.login)) ] [] ]


viewUserResult : UserResult -> List (Html Msg)
viewUserResult result =
    List.map viewUser (List.take 5 result.items)


view : Model -> Html Msg
view model =
    case model.userResult of
        RemoteData.Success result ->
            div []
                (viewUserResult result)

        RemoteData.Loading ->
            div [] [ text "Loading" ]

        _ ->
            div [] [ text "something else happened" ]
