module Shot exposing (shot)

import Svg exposing (svg, polygon)
import Svg.Attributes exposing (width, height, viewBox, points)


shot drinks =
    let
        viewWidth =
            5 * drinks
    in
        svg
            [ width "100"
            , height "100"
            , viewBox
                (String.join " "
                    (List.map toString [ 0, 0, viewWidth, 10 ])
                )
            ]
            (List.map
                (\x -> glass (x * 5))
                (List.range 0 (ceiling drinks))
            )


glass startX =
    let
        x1 =
            startX

        x2 =
            startX + 5

        x3 =
            x2 - 1

        x4 =
            x1 + 1
    in
        polygon
            [ points
                (pointsToString
                    [ ( x1, 0 )
                    , ( x2, 0 )
                    , ( x3, 5 )
                    , ( x4, 5 )
                    ]
                )
            ]
            []


pointsToString points =
    String.join " "
        (List.map
            (\t ->
                (pointToString
                    (Tuple.first t)
                    (Tuple.second t)
                )
            )
            points
        )


pointToString x y =
    String.append (toString x) (String.append "," (toString y))
