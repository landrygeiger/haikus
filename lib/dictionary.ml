let is_alpha = function 'a' .. 'z' | 'A' .. 'Z' -> true | _ -> false

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
