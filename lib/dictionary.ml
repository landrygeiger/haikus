module Util = struct
  let is_alpha = function 'a' .. 'z' | 'A' .. 'Z' -> true | _ -> false

  (** By stackoverflow user "Ptival" 4/9/2012 *)
  let explode s =
    let rec exp i l = if i < 0 then l else exp (i - 1) (s.[i] :: l) in
    exp (String.length s - 1) []

  let rec unexplode = function
    | c :: cs -> String.make 1 c ^ unexplode cs
    | [] -> ""

  let filter_chars pred str = str |> explode |> List.filter pred |> unexplode
  let filter_non_alphanumerics = filter_chars is_alpha

  let words_from_text str =
    str
    |> Str.split (Str.regexp "[ \n\r\x0c\t]+")
    |> List.map filter_non_alphanumerics
    |> List.map String.lowercase_ascii

  (** By stackoverflow user "aneccodeal" 4/25/2011 *)
  let read_file path =
    let lines = ref [] in
    let chan = open_in path in
    try
      while true do
        lines := input_line chan :: !lines
      done;
      !lines
    with End_of_file ->
      close_in chan;
      List.rev !lines
end

module Syllable : sig
  val load_table : string -> (string, int) Hashtbl.t
  val get_for_word : ('a, int) Hashtbl.t -> 'a -> int
  val total_for_text : (string, int) Hashtbl.t -> string -> int
  val convert_mhyph : unit -> unit
end = struct
  let syllable_delimiter = ' '

  let table_entry_from_line line =
    let word =
      line
      |> String.split_on_char syllable_delimiter
      |> List.fold_left (fun acc x -> acc ^ x) ""
    in
    let syllables =
      line |> String.split_on_char syllable_delimiter |> List.length
    in
    (word, syllables)

  let load_table path =
    let lines = Util.read_file path in
    let table = ref (Hashtbl.create (List.length lines)) in
    Util.read_file path
    |> List.map table_entry_from_line
    |> List.iter (fun (word, syllables) -> Hashtbl.add !table word syllables);
    !table

  let get_for_word table word =
    match Hashtbl.find_opt table word with Some n -> n | None -> 0

  let total_for_text table text =
    text |> Util.words_from_text
    |> List.map (get_for_word table)
    |> List.fold_left (fun acc x -> acc + x) 0

  let convert_mhyph () =
    let oc = open_out "syllables.txt" in
    Util.read_file "mhyph.txt"
    |> List.map (Str.global_replace (Str.regexp "[^a-zA-Z]+") " ")
    |> (function
         | x :: xs ->
             List.fold_left (fun acc x -> acc ^ "\n" ^ String.trim x) x xs
         | [] -> "")
    |> Printf.fprintf oc "%s"
end
