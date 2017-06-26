module Types exposing (..)

import Navigation exposing (Location)
import RemoteData exposing (WebData)


type Route
    = HomeRoute
    | UsersRoute String
    | ReposRoute String


type alias Model =
    { route : Route
    , searchInput : String
    , userResult : WebData UserResult
    , repoResult : WebData RepoResult
    }


type alias UserResult =
    { total_count : Int
    , incomplete_results : Bool
    , items : List User
    }


type alias User =
    { id : Int
    , avatar_url : String
    , url : String
    , html_url : String
    , login : String
    }


type alias RepoResult =
    { total_count : Int
    , incomplete_results :
        Bool
    , items : List Repo
    }


type alias Repo =
    { id : Int
    , name : String
    , html_url : String
    , description : String
    , language : String
    }


type Msg
    = OnLocationChange Location
    | UpdateSearch String
    | SubmitSearch
    | OnFetchUsers (WebData UserResult)
    | OnFetchRepos (WebData RepoResult)
    | GoTo Route
