open Lwt.Infix

let base_url = "https://api.groupme.com/v3"

module Group = struct
  type t = { id : string; name : string }

  let make_url api_token =
    Rest.make_authenticated_route_url ~base_url ~path:"/groups" ~api_token

  let from_json json_group =
    let open Yojson.Basic.Util in
    let id = json_group |> member "id" |> to_string in
    let name = json_group |> member "name" |> to_string in
    { id; name }

  let all_from_body body =
    let open Yojson.Basic.Util in
    body |> Cohttp_lwt.Body.to_string >|= Yojson.Basic.from_string
    >|= member "response" >|= to_list >|= List.map from_json

  let fetch_active ~api_token =
    let groups_url = make_url api_token in
    Rest.send_request groups_url >|= snd >>= all_from_body
end

module Message = struct
  type t = { id : string; name : string; text : string; user_id : string }

  let make_url ~api_token ~group_id ~limit ~before_id =
    let base_path = "/groups/" ^ group_id ^ "/messages" in
    let limit = Int.to_string limit in
    Rest.make_authenticated_route_url ~base_url ~path:base_path ~api_token
    |> Rest.concat_query_param ~param:"limit" ~value:limit
    |>
    match before_id with
    | Some before_id ->
        Rest.concat_query_param ~param:"before_id" ~value:before_id
    | None -> fun x -> x

  let from_json json_message =
    let open Yojson.Basic.Util in
    let id = json_message |> member "id" |> to_string in
    let text =
      json_message |> member "text" |> fun json ->
      match json with `Null -> "" | _ -> to_string json
    in
    let user_id = json_message |> member "user_id" |> to_string in
    let name = json_message |> member "name" |> to_string in
    { id; text; user_id; name }

  let all_from_body body =
    let open Yojson.Basic.Util in
    let%lwt test_body = Cohttp_lwt.Body.to_string body in
    test_body |> Yojson.Basic.from_string |> member "response"
    |> member "messages" |> to_list |> List.map from_json |> Lwt.return

  let fetch_all_for_group ~api_token ~group_id ~chunk_size =
    let rec fetch_next_messages ~before_id =
      let messages_url =
        make_url ~api_token ~group_id ~limit:chunk_size ~before_id
      in
      let%lwt res = Rest.send_request messages_url in
      let%lwt messages_chunk =
        try%lwt res |> snd |> all_from_body with _ -> Lwt.return []
      in
      let reversed_chunk = List.rev messages_chunk in
      match reversed_chunk with
      | m :: _ ->
          let%lwt next_messages =
            fetch_next_messages ~before_id:(Option.Some m.id)
          in
          Lwt.return (messages_chunk @ next_messages)
      | [] -> Lwt.return []
    in
    fetch_next_messages ~before_id:Option.None
end
