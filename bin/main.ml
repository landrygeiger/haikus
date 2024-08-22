let () =
  Dotenv.export ();
  let api_token = Sys.getenv "GROUPME_API_TOKEN" in
  let messages_request =
    Haikus.Groupme.fetch_messages_for_group ~api_token ~group_id:"90085950"
      ~chunk_size:100
  in
  Lwt_main.run messages_request |> List.length |> Int.to_string |> print_endline
