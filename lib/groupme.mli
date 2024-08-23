module Group : sig
  type t = { id : string; name : string }

  val to_string : t -> string
  val from_json : Yojson.Basic.t -> t
  val all_from_body : Cohttp_lwt.Body.t -> t list Lwt.t
  val fetch_active : api_token:string -> t list Lwt.t
end

module Message : sig
  type t = { id : string; name : string; text: string; user_id: string }

  val from_json : Yojson.Basic.t -> t
  val all_from_body : Cohttp_lwt.Body.t -> t list Lwt.t
  val fetch_all_for_group : api_token:string -> group_id:string -> chunk_size:int -> t list Lwt.t
end
