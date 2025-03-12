type braun = E|N of int*braun*braun;;

let height b =
  let rec aux abr acc =
    match abr with
    | E -> acc-1
    | N(_,g,_) -> aux abr (acc+1)
  in
  aux b 0
;;

let rec diff t n =
  match t,n with 
  |E, _ -> 0
  |N(x,E,E),0 -> 1
  |N(_,g,d), n when n mod 2 = 0 -> diff d (n/2 -1)
  |N(_,g,d), n when n mod 2 = 1 -> diff g (n/2)
  |_ -> failwith "erreur"
;;

let rec size t =
  match t with
  |E -> 0
  |N(_,g,d) ->
    let s = size d in
    2*(s) + 1 + diff g s
;;

let get_min t =
  match t with
  |E -> max_int
  |N(x,_,_) -> x
;;

