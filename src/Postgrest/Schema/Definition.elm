module Postgrest.Schema.Definition exposing
    ( Column
    , Definition
    , columnValue
    , primaryKeyName
    , toResource
    )

import Dict exposing (Dict)
import Dict.Extra as Dict
import Postgrest.Field exposing (Field)
import Postgrest.Value as Value exposing (Value)


type alias Column =
    { required : Bool
    , value : Value
    }


type alias Definition =
    Dict String Column


toResource : Definition -> Dict String Field
toResource definition =
    Dict.map (\_ col -> columnToField col) definition


columnToField : Column -> Field
columnToField { required, value } =
    { error = Nothing
    , required = required
    , changed = False
    , value = value
    }


primaryKeyName : Definition -> Maybe String
primaryKeyName definition =
    Dict.find (\_ { value } -> Value.isPrimaryKey value) definition
        |> Maybe.map Tuple.first


columnValue : Column -> Value
columnValue { value } =
    value
