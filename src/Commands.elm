module Commands exposing (..)

import Http
import Json.Decode.Pipeline exposing (decode, required)
import Types exposing (Msg(..), User, UserResult)
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


decodeUserResult : Json.Decode.Decoder UserResult
decodeUserResult =
    Json.Decode.Pipeline.decode UserResult
        |> Json.Decode.Pipeline.required "total_count" (Json.Decode.int)
        |> Json.Decode.Pipeline.required "incomplete_results" (Json.Decode.bool)
        |> Json.Decode.Pipeline.required "items" (Json.Decode.list decodeUser)



-- https://api.github.com/search/repositories?q=+user:emmacunningham
-- https://api.github.com/search/users?q=emma


fetchUsers : String -> Cmd Msg
fetchUsers searchTerm =
    Http.get (usersUrl ++ searchTerm) decodeUserResult
        |> RemoteData.sendRequest
        |> Cmd.map OnFetchUsers


usersUrl : String
usersUrl =
    "https://api.github.com/search/users?q="



-- usersDecoder : Decode.Decoder (List User)
-- usersDecoder =
--     Decode.list userDecoder
-- userDecoder : Decode.Decoder User
-- userDecoder =
--     decode User
--         |> required "id" Decode.string
