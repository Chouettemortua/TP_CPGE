let rec pour_tout pred u =
  match u with
  | [] -> true
  | x::xs -> if pred x = true then pour_tout pred xs else false
;;
assert(pour_tout (fun x ->  x mod 2 = 0 ) [1;2;3;4;5;6] = false);;
assert(pour_tout (fun x -> x mod 2 = 0) [2;4;6] = true);;

let rec existe pred u =
  match u with
  | [] -> false
  | x::xs -> if pred x = true then true else existe pred xs
;; 
assert(existe (fun x ->  x mod 2 = 0 ) [1;3;5] = false);;
assert(existe (fun x ->  x mod 2 = 0) [2;4;3;6] = true);;

let rec filtre pred u =
  match u with
  | [] -> []
  | x::xs -> if pred x then x::(filtre pred xs) else filtre pred xs
;;

assert(filtre (fun x ->  x mod 2 = 0 ) [1;3;5] = []);;
assert(filtre (fun x -> x mod 2 = 0 ) [2;4;3;6] = [2;4;6]);;

let appartient x u = existe (fun y -> y=x) u;;

let rec inclus u v = 
  match u,v with
  |[],_ -> true
  |_,[] -> false
  |x::xs,_ -> if appartient x v then inclus xs v else false  
;;

let egal u v = inclus u v && inclus v u ;;

let rec inter u v =
  match u,v with
  |[], _ -> []
  |_,[] -> []
  |x::xs,_ -> if appartient x v then x::(inter xs v) else inter xs v
;;

let rec prive_de u v =
  match u with
  |[] -> []
  |x::xs -> if appartient x v then prive_de xs v else x::(prive_de xs v)
;;

let union u v = u @ prive_de v u;;

let rec better_union u v =
  match u , v with
  |u,[] -> u
  |[],v -> v
  |x::xs,y::ys -> 
    if x<y then x::(better_union xs v)
    else y::(better_union u ys)
;;
union [1;2;3;4;5;6;7;8;9] [4;5;6;7;8;9];;
better_union [1;2;3;4;5;6;7;8;9] [4;5;6;7;8;9];;
inter [1;2;3;4;5;6;7;8;9] [4;5;6;7;8;9];;
prive_de [1;2;3;4;5;6;7;8;9] [4;5;6;7;8;9];;

let rec better_inclu u v =
  match u , v with
  |[],_ -> true
  |_,[] -> false
  |x::xs,y::ys -> 
    if x=y then better_inclu xs ys
    else 
      better_inclu u ys
;;

let better_egal u v = better_inclu u v && better_inclu v u ;;

let rec eclate u =
  match u with
  |[] -> ([],[])
  |[x] -> ([], [x])
  |[x;y] -> ([x],[y])
  |x::y::xs -> let g,d = eclate xs in
              (x::g, y::d)
;;

let rec fusionne u v =
  match u , v with
  |u,[] -> u
  |[],v -> v
  |x::xs,y::ys -> 
    if x<y then x::(fusionne xs v)
    else 
    if x>y then y::(fusionne u ys)
    else x::(fusionne xs ys)
;;

let rec tri_unique u =
  match u with
  |[] -> []
  |[x]->[x]
  |x::xs-> 
    let g,d = eclate u in
    fusionne (tri_unique g) (tri_unique d)
;;

tri_unique [1;2;3;4;5;6;7;8;9;4;5;6;7;8;9];;
