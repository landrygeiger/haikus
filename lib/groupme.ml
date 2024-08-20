open Lwt.Infix

type group = { id : string; name : string }

let api_url = "https://api.groupme.com/v3"

let groups_url api_token =
  Rest.make_authenticated_route_url ~base_url:api_url ~path:"/groups"
    ~token:api_token

let parse_json_group json_group =
  let open Yojson.Basic.Util in
  let id = json_group |> member "id" |> to_string in
  let name = json_group |> member "name" |> to_string in
  { id; name }

let get_groups_from_body body =
  body |> Cohttp_lwt.Body.to_string >|= Yojson.Basic.from_string
  >|= Yojson.Basic.Util.member "response"
  >|= Yojson.Basic.Util.to_list >|= List.map parse_json_group

let fetch_active_groups ~api_token =
  Rest.send_request (groups_url api_token) >|= snd >>= get_groups_from_body
