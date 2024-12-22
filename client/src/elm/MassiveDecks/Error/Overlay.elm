module MassiveDecks.Error.Overlay exposing (init, update, view)

import FontAwesome as Icon
import Html exposing (Html)
import Html.Attributes as HtmlA
import MassiveDecks.Error as Error
import MassiveDecks.Error.Messages exposing (..)
import MassiveDecks.Error.Model as Error
import MassiveDecks.Icon as Icon
import MassiveDecks.Messages as Global
import MassiveDecks.Model exposing (Shared)
import MassiveDecks.Pages.Route exposing (Route)
import MassiveDecks.Strings as Strings
import MassiveDecks.Strings.Languages as Lang
import MassiveDecks.Util.NeList as NeList exposing (NeList(..))
import Material.Card as Card
import Material.IconButton as IconButton


init : Error.Overlay
init =
    { errors = [] }


view : Shared -> Route -> Error.Overlay -> List (Html Global.Msg)
view shared route model =
    if List.isEmpty model.errors then
        []

    else
        [ Html.div [ HtmlA.class "error-overlay" ]
            [ Html.div [ HtmlA.class "actions" ]
                [ IconButton.view
                    (Icon.close |> Icon.view)
                    (Strings.Close |> Lang.string shared)
                    (Clear |> Global.ErrorMsg |> Just)
                , IconButton.view
                    (Icon.redo |> Icon.view)
                    (Strings.Refresh |> Lang.string shared)
                    (Just Global.Refresh)
                ]
            , Card.view [ HtmlA.class "help" ]
                [ Html.h3 [] [ Lang.html shared Strings.ErrorHelpTitle ]
                , Html.p [] [ Lang.html shared Strings.ErrorHelp ]
                , Html.p [] [ Lang.html shared Strings.ErrorCheckOutOfBand ]
                ]
            , Html.div [ HtmlA.class "errors" ] (List.map (Error.view shared route) model.errors)
            ]
        ]


update : Msg -> Error.Overlay -> Error.Overlay
update msg model =
    case msg of
        Add error ->
            { model | errors = error :: model.errors }

        Clear ->
            { model | errors = [] }
