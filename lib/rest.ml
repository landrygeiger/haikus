let concat_query_param ~param ~value url =
  (if String.contains url '?' then Printf.sprintf "%s&%s=%s"
   else Printf.sprintf "%s?%s=%s")
    url param value

let send_request url = url |> Uri.of_string |> Cohttp_lwt_unix.Client.get
