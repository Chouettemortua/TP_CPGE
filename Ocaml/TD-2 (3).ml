let rec mem x u =
  match u with
  | [] -> false
  | y::ys -> y=x || mem x ys
;;
assert (false=mem 2 [1;3;4]);;
assert (true=mem 2 [1;3;2;4]);;

print_newline();;

let rec nth u n =
  match u with
  | [] -> failwith "indice non compris"
  | x::xs -> if n=0 then x else nth xs (n-1)
;;
nth [1;3;4] 4;;
assert (4=nth [1;3;4] 2);;

print_newline();;

let rec take n u =
  match u with
  | [] -> []
  | x::xs -> if n=1 then [x] else x::take (n-1) xs
;;
assert ([1;2;3]=take 3 [1;2;3;4;5;7;8]);;
assert ([1;2;3;4;5;6]=take 9 [1;2;3;4;5;6]);;

print_newline();;

let rec range a b=
  if a<b then a::range (a+1) b else []
;;
assert ([1;2]=range 1 3);;

print_newline();;

let rec concat u v =
  match u with
  |[] -> v
  |[x] -> x::v
  | x::xs -> x::concat xs v
;;
assert ([1;2;3;4;5;6] = concat [1;2;3] [4;5;6]);;
assert ([3;2;1]=concat (concat (concat [] [3]) [2]) [1]);;

print_newline();;

let rec miroir_naif liste =
  match liste with
  |[] -> []
  |x::xs -> concat (miroir_naif xs) [x] 
;;
assert ([3;2;1]=miroir_naif [1;2;3]);;

print_newline();;

let rec rev_append u v =
  match u with
  | [] -> v
  | x::xs -> rev_append xs (x::v)
;;
assert ([3;2;1;4;5;6] = rev_append [1;2;3] [4;5;6]);;

print_newline();;

let rec miroir liste = rev_append liste [];;
assert ([3;2;1]=miroir [1;2;3]);;

print_newline();;

let test a = a+2;;
let rec applique f liste =
  match liste with
  | [] -> []
  | x::xs -> (f x)::(applique f xs)
;;
assert ([3;4;5]=applique test [1;2;3]);;

print_newline();;

let liste_carre liste = applique (fun a -> a*a) liste;;
assert ([1;4;9]= liste_carre [1;2;3]);;

print_newline();;

let rec sans_doublon_triee liste =
  match liste with
  | [] -> true
  | [x] -> true
  |x::y::xs -> if x = y then false else sans_doublon_triee (y::xs)
;;
assert (true=sans_doublon_triee [1;2;3]);;
assert (false=sans_doublon_triee [1;2;2;3]);;

let rec sans_doublon liste =
  match liste with
  | [] -> true
  | x::xs -> if mem x xs then false else sans_doublon xs
;;

assert (true=sans_doublon [1;2;3]);;
assert (false=sans_doublon [1;2;3;2]);;

