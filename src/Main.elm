module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput, onClick)
import Result as Result


main : Program Never Model Msg
main =
    Html.beginnerProgram
        { model = model
        , view = view
        , update = update
        }



-- MODEL


type alias Model =
    { percent : String
    , volume : String
    }


model : Model
model =
    (Model initPercent initVolume)


initPercent : String
initPercent =
    "7"


initVolume : String
initVolume =
    "12"



-- UPDATE


type Msg
    = UpdatePercent String
    | UpdateVolume String


update : Msg -> Model -> Model
update msg model =
    case msg of
        UpdatePercent percent ->
            { model | percent = percent }

        UpdateVolume volume ->
            { model | volume = volume }



-- VIEW


view : Model -> Html Msg
view model =
    div []
        [ h1 [] [ text "Drinks!" ]
        , p [] [ text "How many drinks is that high percentage beer?" ]
        , percentView model.percent
        , volumeView model.volume
        , drinksView
            (calculateDrinks
                (Result.withDefault 1 (String.toFloat model.percent))
                (Result.withDefault 0 (String.toFloat model.volume))
            )
        ]


percentView : String -> Html Msg
percentView percent =
    label [ class "percent" ]
        [ text "percent"
        , input
            [ type_ "number"
            , value percent
            , onInput UpdatePercent
            ]
            []
        ]


volumeView : String -> Html Msg
volumeView volume =
    div [ class "volume-view" ]
        [ label [ class "volume" ]
            [ text "volume"
            , input
                [ type_ "number"
                , value volume
                , onInput UpdateVolume
                ]
                []
            ]
        , volumePresetsView
        ]


volumePresetsView : Html Msg
volumePresetsView =
    div [ class "volume-presets" ]
        (List.map buttonPreset volumePresets)


volumePresets : List Preset
volumePresets =
    List.map presetFromTuple
        [ ( "tulip", 10 )
        , ( "can", 12 )
        , ( "pint", 16 )
        , ( "bomber", 22 )
        ]


presetFromTuple : ( String, Float ) -> Preset
presetFromTuple tuple =
    (Preset (Tuple.first tuple) (Tuple.second tuple))


type alias Preset =
    { name : String
    , value : Float
    }


buttonPreset : Preset -> Html Msg
buttonPreset { name, value } =
    button
        [ class name
        , onClick (UpdateVolume (toString value))
        ]
        [ text name ]


drinksView : Float -> Html Msg
drinksView drinks =
    div [ class "drinks" ]
        [ text
            (String.append
                "drinks: "
                (toString drinks)
            )
        ]



-- 1 drink is a 1 1/2 oz shot of 40% liquor
-- x * 0.4 * (3/2) = percent * volume


calculateDrinks : Float -> Float -> Float
calculateDrinks percent volume =
    (percent * volume) / (40 * (3 / 2))
