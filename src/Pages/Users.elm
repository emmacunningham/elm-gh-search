module Pages.Users exposing (..)

import Html exposing (Html, div, text, input, img)
import Html.Events as Events
import Html.Attributes as Attributes exposing (class, style)
import Types exposing (Msg(..), Model, UserResult, User, Route(..))
import RemoteData exposing (WebData)


viewUser : User -> Html Msg
viewUser user =
    div
        [ class "user-container"
        , Events.onClick (GoTo (ReposRoute user.login))
        , style [ ( "background-image", "url(" ++ user.avatar_url ++ ")" ) ]
        ]
        []


viewUserResult : UserResult -> List (Html Msg)
viewUserResult result =
    List.map viewUser (List.take 50 result.items)


view : Model -> Html Msg
view model =
    case model.userResult of
        RemoteData.Success result ->
            div [ class "users-container" ]
                (viewUserResult result)

        RemoteData.Loading ->
            div [ class "loading" ] [ text "Loading" ]

        RemoteData.Failure err ->
            div [] [ text ("Error: " ++ toString err) ]

        _ ->
            div [] [ text "something else happened" ]
