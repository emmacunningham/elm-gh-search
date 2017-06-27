module Pages.Repos exposing (..)

import Html exposing (Html, div, text, input, a, h2, img)
import Html.Events as Events
import Html.Attributes as Attributes exposing (class)
import Types exposing (Msg(..), Model, Repo, RepoResult, Route(..))
import RemoteData exposing (WebData)


viewWatcher : Html Msg
viewWatcher =
    img [ class "watchers", Attributes.src "https://cdn.shopify.com/s/files/1/1061/1924/files/Face_With_Rolling_Eyes_Emoji.png?9898922749706957214" ] []


viewWatchers : Int -> List (Html Msg)
viewWatchers count =
    List.repeat count viewWatcher


viewRepo : Repo -> Html Msg
viewRepo repo =
    let
        watchers =
            if repo.watchers == 0 then
                text "none"
            else
                div [] (viewWatchers repo.watchers)
    in
        div [ class "repo-container" ]
            [ a [ Attributes.href repo.html_url, Attributes.target "_blank" ] [ text repo.name ]
            , div [] [ text ("Primary language: " ++ repo.language) ]
            , div [ class "watch-label" ] [ text "Watchers: " ]
            , watchers
            ]


viewRepoResult : RepoResult -> List (Html Msg)
viewRepoResult result =
    List.map viewRepo result.items


view : Model -> Html Msg
view model =
    let
        user =
            case model.route of
                ReposRoute user ->
                    user

                _ ->
                    ""
    in
        case model.repoResult of
            RemoteData.Success result ->
                div [ class "results-container" ]
                    [ h2 [] [ text (user ++ "'s repositories") ]
                    , div [ class "repos-container" ] (viewRepoResult result)
                    ]

            RemoteData.Loading ->
                div [ class "loading" ] [ text "Loading" ]

            RemoteData.Failure err ->
                div [] [ text ("Error: " ++ toString err) ]

            _ ->
                div [] [ text "something else happened" ]
