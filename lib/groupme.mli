module Group : sig
  type t = { id : string; name : string }

  val from_json : Yojson.Basic.t -> t
  val from_body : Cohttp_lwt.Body.t -> t list Lwt.t
  val fetch_active : api_token:string -> t list Lwt.t
end

type message = { id : string; name : string; text : string; user_id : string }

val fetch_messages_for_group : api_token:string -> group_id:string -> chunk_size:int -> message list Lwt.t
val make_messages_url : api_token:string -> group_id:string -> limit:int -> before_id:string Option.t -> string
