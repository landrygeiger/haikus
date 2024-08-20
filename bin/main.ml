let () =
  Dotenv.export ();
  let api_token = Sys.getenv "GROUPME_API_TOKEN" in
  let groups_request = Haikus.Groupme.fetch_active_groups ~api_token in
  Lwt_main.run groups_request
  |> List.map (fun group -> group.Haikus.Groupme.id)
  |> List.iter print_endline
