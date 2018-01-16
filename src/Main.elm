module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput)
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
        , label [ class "percent" ]
            [ text "percent"
            , input
                [ type_ "number"
                , value model.percent
                , onInput UpdatePercent
                ]
                []
            ]
        , label [ class "volume" ]
            [ text "volume"
            , input
                [ type_ "number"
                , value model.volume
                , onInput UpdateVolume
                ]
                []
            ]
        , div [ class "drinks" ]
            [ text
                (String.append
                    "drinks: "
                    (toString
                        (calculateDrinks
                            (Result.withDefault 0 (String.toFloat model.percent))
                            (Result.withDefault 0 (String.toFloat model.volume))
                        )
                    )
                )
            ]
        ]



-- 1 drink is a 1 1/2 oz shot of 40% liquor
-- x * 0.4 * (3/2) = percent * volume


calculateDrinks : Float -> Float -> Float
calculateDrinks percent volume =
    (percent * volume) / (40 * (3 / 2))



-- onInput : (Float -> msg) -> Attribute msg
-- onInput tagger =
--     on "input" (Json.map tagger targetValue)
-- targetValue : Json.Decoder Float
-- targetValue =
--     Json.at [ "target", "value" ] Json.float
