type group = {
    id: string;
    name: string
}

val fetch_active_groups : api_token:string -> group list Lwt.t
