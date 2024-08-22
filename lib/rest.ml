let concat_query_param ~param ~value url =
  (if String.contains url '?' then Printf.sprintf "%s&%s=%s"
   else Printf.sprintf "%s?%s=%s")
    url param value

let make_authenticated_route_url ~base_url ~path ~api_token =
  concat_query_param ~param:"token" ~value:api_token (base_url ^ path)

let send_request url = url |> Uri.of_string |> Cohttp_lwt_unix.Client.get
