let () =
  Dotenv.export ();
  let api_token = Sys.getenv "GROUPME_API_TOKEN" in
  let messages_request =
    Haikus.Groupme.Message.fetch_all_for_group ~api_token ~group_id:"90085950"
      ~chunk_size:100
  in
  let messages = Lwt_main.run messages_request in
  let syllable_table = Haikus.Dictionary.Syllable.load_table "syllables.txt" in
  messages
  |> List.map (fun m -> m.Haikus.Groupme.Message.text)
  |> List.map (fun text ->
         (text, Haikus.Dictionary.Syllable.total_for_text syllable_table text))
  |> List.filter (fun (_, syllables) -> syllables = 17)
  |> List.map (fun (text, syllables) -> Int.to_string syllables ^ ": " ^ text)
  |> List.iter print_endline
