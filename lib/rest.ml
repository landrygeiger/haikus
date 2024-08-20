let concat_query_param ~url ~param ~value =
  Printf.sprintf "%s?%s=%s" url param value

let make_authenticated_route_url ~base_url ~path ~token =
  concat_query_param ~url:(base_url ^ path) ~param:"token" ~value:token

let send_request url = url |> Uri.of_string |> Cohttp_lwt_unix.Client.get
