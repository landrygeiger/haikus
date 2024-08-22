type group = { id : string; name : string }

type message = { id : string; name : string; text : string; user_id : string }

val fetch_active_groups : api_token:string -> group list Lwt.t
val fetch_messages_for_group : api_token:string -> group_id:string -> chunk_size:int -> message list Lwt.t
val make_messages_url : api_token:string -> group_id:string -> limit:int -> before_id:string Option.t -> string
