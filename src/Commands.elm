module Commands exposing (..)

import Http
import Json.Decode.Pipeline exposing (decode, required)
import Types exposing (Msg(..), User, UserResult, Repo, RepoResult)
import RemoteData
import Json.Decode
import Json.Decode.Pipeline


decodeUser : Json.Decode.Decoder User
decodeUser =
    Json.Decode.Pipeline.decode User
        |> Json.Decode.Pipeline.required "id" (Json.Decode.int)
        |> Json.Decode.Pipeline.required "avatar_url" (Json.Decode.string)
        |> Json.Decode.Pipeline.required "url" (Json.Decode.string)
        |> Json.Decode.Pipeline.required "html_url" (Json.Decode.string)
        |> Json.Decode.Pipeline.required "login" (Json.Decode.string)


decodeUserResult : Json.Decode.Decoder UserResult
decodeUserResult =
    Json.Decode.Pipeline.decode UserResult
        |> Json.Decode.Pipeline.required "total_count" (Json.Decode.int)
        |> Json.Decode.Pipeline.required "incomplete_results" (Json.Decode.bool)
        |> Json.Decode.Pipeline.required "items" (Json.Decode.list decodeUser)


decodeRepo : Json.Decode.Decoder Repo
decodeRepo =
    Json.Decode.Pipeline.decode Repo
        |> Json.Decode.Pipeline.required "id" (Json.Decode.int)
        |> Json.Decode.Pipeline.required "name" (Json.Decode.string)
        |> Json.Decode.Pipeline.required "html_url" (Json.Decode.string)
        |> Json.Decode.Pipeline.optional "description" (Json.Decode.string) ""
        |> Json.Decode.Pipeline.optional "language" (Json.Decode.string) ""


decodeRepoResult : Json.Decode.Decoder RepoResult
decodeRepoResult =
    Json.Decode.Pipeline.decode RepoResult
        |> Json.Decode.Pipeline.required "total_count" (Json.Decode.int)
        |> Json.Decode.Pipeline.required "incomplete_results" (Json.Decode.bool)
        |> Json.Decode.Pipeline.required "items" (Json.Decode.list decodeRepo)


fetchUsers : String -> Cmd Msg
fetchUsers searchTerm =
    Http.get (usersUrl ++ searchTerm) decodeUserResult
        |> RemoteData.sendRequest
        |> Cmd.map OnFetchUsers


fetchRepos : String -> Cmd Msg
fetchRepos userName =
    Http.get (reposUrl ++ userName) decodeRepoResult
        |> RemoteData.sendRequest
        |> Cmd.map OnFetchRepos


usersUrl : String
usersUrl =
    "https://api.github.com/search/users?q="


reposUrl : String
reposUrl =
    "https://api.github.com/search/repositories?q=+user:"
