module Types exposing (..)

import Navigation exposing (Location)
import RemoteData exposing (WebData)


type Route
    = HomeRoute
    | SearchRoute String
    | ReposRoute String


type alias Model =
    { route : Route
    , searchInput : String
    , userResult : WebData UserResult
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
    }


type Msg
    = OnLocationChange Location
    | UpdateSearch String
    | SubmitSearch
    | OnFetchUsers (WebData UserResult)
