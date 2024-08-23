let syllables_db_path = "syllables.txt"

let fetch_haikus ~api_token ~group_id =
  let%lwt messages =
    Haikus.Groupme.Message.fetch_all_for_group ~api_token ~group_id
      ~chunk_size:100
  in
  let syllable_table =
    Haikus.Dictionary.Syllable.load_table syllables_db_path
  in
  messages
  |> List.map (fun m -> m.Haikus.Groupme.Message.text)
  |> List.map (fun text ->
         (text, Haikus.Dictionary.Syllable.total_for_text syllable_table text))
  |> List.filter (fun (_, syllables) -> syllables = 17)
  |> List.map fst
  |> List.map (fun s -> s ^ "\n")
  |> Lwt.return

let () =
  Dotenv.export ();
  let api_token = Sys.getenv "GROUPME_API_TOKEN" in
  let groups = Haikus.Groupme.Group.fetch_active ~api_token |> Lwt_main.run in
  groups
  |> List.iter (fun group ->
         group |> Haikus.Groupme.Group.to_string |> print_endline);
  let group_id =
    print_endline "\nEnter a group id:";
    read_line ()
  in
  print_endline "";
  let haikus = fetch_haikus ~api_token ~group_id |> Lwt_main.run in
  haikus |> List.iter print_endline
