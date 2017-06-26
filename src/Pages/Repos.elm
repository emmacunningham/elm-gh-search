module Pages.Repos exposing (..)

import Html exposing (Html, div, text, input, a)
import Html.Events as Events
import Html.Attributes as Attributes
import Types exposing (Msg(..), Model, Repo, RepoResult)
import RemoteData exposing (WebData)


viewRepo : Repo -> Html Msg
viewRepo repo =
    div [] [ a [ Attributes.href repo.html_url, Attributes.target "_blank" ] [ text repo.name ] ]


viewRepoResult : RepoResult -> List (Html Msg)
viewRepoResult result =
    List.map viewRepo result.items


view : Model -> Html Msg
view model =
    case model.repoResult of
        RemoteData.Success result ->
            div []
                (viewRepoResult result)

        RemoteData.Loading ->
            div [] [ text "Loading" ]

        RemoteData.Failure err ->
            div [] [ text ("Error: " ++ toString err) ]

        _ ->
            div [] [ text "something else happened" ]
