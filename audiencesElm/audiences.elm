import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Json.Decode as Json
import Task
import Navigation

import Http

main =
  Navigation.program UrlChange
    { init = init
    , view = view
    , update = update
    , subscriptions = (\_ -> Sub.none)
    }

-- CONFIG URL for API endpoints - currently loaded from local source files, but localhost server must be running

type alias Config = 
    { audienceFoldersUrl : String, audiencesUrl : String }

config : Config
config = 
    { audienceFoldersUrl = "./data/audience-folders.json"
    , audiencesUrl = "./data/audiences.json" }


-- MODEL

type alias AudienceFolder =
    { id : Int, name : String, parent : Int }

type alias Audience =
    { id : Int, name : String, folder : Int }

emptyAudienceFolder : AudienceFolder
emptyAudienceFolder =
    { id = 0, name = "", parent = 0 }


-- Main model object

type alias Model =
  { folder: Int
    , audienceFolders : List AudienceFolder
    , audiences : List Audience
  }

emptyModel : Model
emptyModel =
  { audienceFolders = []
  , folder = 0
  , audiences = []
  }

{-
init : Navigation.Location -> ( Model, Cmd Msg )
init location =
  ( Model [ location ]
  , Cmd.none
  )
-}
init : Navigation.Location -> (Model, Cmd Msg)
init location =
  ({ emptyModel | folder = getFolderIdFromLocation location } 
  , Cmd.batch [
      Task.attempt LoadFolders getAllFolders
      , Task.attempt LoadAudiences getAllAudiences
      ]
  )


-- UPDATE


type Msg
    = LoadFolders (Result Http.Error (List AudienceFolder))
    | LoadAudiences (Result Http.Error (List Audience))
    | UrlChange Navigation.Location


update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    UrlChange location ->
        let
          folderId = getFolderIdFromLocation location
        in
          ({ model | folder = folderId }, Cmd.none)
    
    LoadFolders (Ok newFolders) ->
        ( { model | audienceFolders = newFolders }
        , Cmd.none
        )

    LoadFolders (Err _) ->
        (model, Cmd.none)

    LoadAudiences (Ok newAudiences) ->
        ( { model | audiences = newAudiences }
        , Cmd.none
        )

    LoadAudiences (Err _) ->
        (model, Cmd.none)


-- CSS definitions

itemStyle : List (String, String)
itemStyle = 
    [ ("display", "block") 
    , ("padding", "1em")
    , ("background", "#1a7199")
    , ("color", "white")
    , ("margin", "0.5em 0")
    , ("border-radius", "4px")
    , ("text-decoration", "none") 
    ]

audienceStyle : List (String, String)
audienceStyle = 
    [ ("background", "#1897cd")
    , ("margin", "0.2em")
    ]

-- Useful curom functions

getFolderById : Int -> List(AudienceFolder) -> AudienceFolder
getFolderById id folders =
    let
        filtered =
            List.filter (\i -> i.id == id) folders
    in
        case List.head filtered of
            Nothing ->
                emptyAudienceFolder

            Just item ->
                item

getFolderLink : Int -> String
getFolderLink folderId =
    "#folder" ++ toString folderId

isFolderSelected : Int -> Bool
isFolderSelected folder = 
    folder > 0

getFolderIdFromLocation : Navigation.Location -> Int
getFolderIdFromLocation location =
    let
        flderIdLength = (String.length location.hash) - 7
        folderRes = String.toInt (String.right flderIdLength location.hash)
    in
        case folderRes of
            Ok folder ->
                folder
            Err err ->
                0

-- VIEW


view : Model -> Html Msg
view model =
    let
        currentFolder = getFolderById model.folder model.audienceFolders
        mainElement = 
        if isFolderSelected model.folder 
        then 
            a [ 
                href (getFolderLink currentFolder.parent), 
                style itemStyle 
            ] [ text (" ← "  ++ currentFolder.name) ] 
        else 
            span [] [] -- I know, better be return Nothing for this case, but it means rewrite to Maybe types
    in
    div [ style [ ("padding", "1em") ] ]
        [ h2 [] [ text "Audiences listing" ]
        , div [] [
            mainElement, 
            viewAudienceFolders model,
            viewAudiences model
        ]
        , br [] []
        ]

viewAudienceFolders : Model -> Html Msg
viewAudienceFolders model =
    let
      audience_folders = List.filter (\folder -> folder.parent == model.folder) model.audienceFolders
    in
      div [] (
          List.map singleFolderToHtml audience_folders 
    )


singleFolderToHtml : AudienceFolder -> Html Msg
singleFolderToHtml audienceFolder =
        a [ href (getFolderLink audienceFolder.id), style itemStyle] 
        [ text (audienceFolder.name) ]

viewAudiences : Model -> Html Msg
viewAudiences model =
    let
      audiences = List.filter (\audience -> audience.folder == model.folder) model.audiences
      audiencesHtml = 
        if isFolderSelected model.folder && List.length audiences > 0
        then 
            ul [ style [("list-tyle", "none"), ("padding", "0")] ] (
                List.map (\audience -> li [ style (itemStyle ++ audienceStyle) ] [ text (audience.name) ]) audiences 
            )
        else
            span [] []
    in
      audiencesHtml


-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.none



-- HTTP / get json datalist


getAllFolders : Task.Task Http.Error (List AudienceFolder)
getAllFolders =
  let
    url =
      config.audienceFoldersUrl
  in
    Http.toTask (Http.get url folderDecoder)

badInt : Json.Decoder Int
badInt =
  Json.oneOf [ Json.int, Json.null 0 ]

folderDecoder : Json.Decoder (List AudienceFolder)
folderDecoder =
  let
    folders = 
        Json.map3 AudienceFolder 
            (Json.field "id" Json.int)
            (Json.field "name" Json.string)
            (Json.field "parent" badInt)
  in
    Json.field "data" (Json.list folders)

getAllAudiences : Task.Task Http.Error (List Audience)
getAllAudiences =
    let
        url =
            config.audiencesUrl
    in
        Http.toTask (Http.get url audienceDecoder)

audienceDecoder : Json.Decoder (List Audience)
audienceDecoder =
  let
    audiences = 
        Json.map3 Audience 
            (Json.field "id" Json.int)
            (Json.field "name" Json.string)
            (Json.field "folder" badInt)
  in
    Json.field "data" (Json.list audiences)


