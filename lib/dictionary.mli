module Syllable : sig
  val load_table : string -> (string, int) Hashtbl.t
  val get_for_word : ('a, int) Hashtbl.t -> 'a -> int
  val total_for_text : (string, int) Hashtbl.t -> string -> int
  val convert_mhyph : unit -> unit
end