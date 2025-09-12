

type 'a abr =
  | V
  | N of 'a abr * 'a * 'a abr
;;

let rec insere ab x =
  match ab with
  | V -> N(V, x , V)
  | N(g, y ,d) -> 
    if x = y then N(g, y, d)
    else if x > y then N(g, y, insere d x)
    else N(insere g x, y, d)
;;

let rec appartient ab x =
  match ab with
  | V -> false
  | N(g, y, d) ->
    if x = y then true
    else if x > y then appartient d x
    else appartient g x
;;

let rec cardinal ab =
  match ab with
  | V -> 0
  |N(g, y, d) -> 1 + cardinal d + cardinal g
;;

let construit list =
  let rec aux lst ab =
    match lst with
    |[] -> ab
    |x::xs -> aux xs (insere ab x)
  in
  aux list V
;;

let elements ab =
  let rec aux a liste =
    match a with
    | V -> liste
    | N(g, y, d) -> 
      aux g (y::(aux d liste))
  in
  aux ab []
;;

let rec extrait_min t =
  match t with
  |V -> failwith "abr vide"
  |N(V, y, d) -> y,d
  |N(g,y,d) ->
    let m, temp = extrait_min g in
    m, N(temp,y,d)
;;

let rec supprime t x =
  match t with
  |V -> V
  |N(g,y,d) when x<y -> N(supprime g x, y, d)
  |N(g,y,d) when x>y -> N(g, y, supprime d x)
  |N(g,y,d) when y=x -> 
    let m, ab = extrait_min d in
    N(g,m,ab)
  |_ -> failwith "imposible"
;;

let rec separe t x =
  match t with
  |V -> V,V 
  |N(g,y,d) when x<y -> 
    let inf, sup = separe g x in
      inf, N(sup,y,d)
  |N(g,y,d) when x>y ->
    let inf, sup = separe d x in
      N(g,y,inf), sup
  |N(g,y,d) when x=y -> 
    N(g,y,N),d
;;

