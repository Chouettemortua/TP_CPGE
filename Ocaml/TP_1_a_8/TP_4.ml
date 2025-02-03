(*TP 4*)

(*Exo 1*)

let extrema t =
  let min = ref t.(0) in
  let max = ref t.(0) in
  let n = Array.length t in
  for i = 1 to n-1 do
    if t.(i) < !min then
      min := t.(i);
    if t.(i) > !max then
      max := t.(i)
  done;
  (!min, !max)
;;
assert((1,4)=extrema [|1;2;3;4|]);;

let nb_occs x t =
  let occ = ref 0 in
  for i = 0 to (Array.length t)-1 do
    if t.(i) = x then
      occ := !occ+1
  done;
  !occ
;;
assert(2=nb_occs 1 [|1;2;3;1|]);;

let tab_occs t =
  let n = (Array.length t) in
  let res = Array.make n 0 in
  for i = 0 to n-1 do
    res.(i) <- nb_occs i t
  done;
  res
;;
assert([|1; 2; 1; 1; 0|]=tab_occs [|0;1;1;2;3|]);;

let tab_occs_eff t =
  let n = (Array.length t) in
  let res = Array.make n 0 in
  for i = 0 to n-1 do
    if t.(i) <= n then res.(t.(i)) <- res.(t.(i))+1
  done;
  res
;;
assert([|1; 2; 1; 1; 0|]=tab_occs_eff [|0;1;1;2;3|]);;

(*Exo 2*)

let somme_cumulees t =
  let n = (Array.length t) in
  let count = ref 0 in
  for i = 0 to n-1 do
    count := !count + t.(i);
    t.(i) <- !count
  done;
  t
;;
assert([|1; 3; 6; 10|] = somme_cumulees [|1;2;3;4|]);;

(*Exo 3*)

let map func t =
  let n = (Array.length t) in
  for i=0 to n-1 do
    t.(i) <- func (t.(i))
  done;
  t
;;
assert([|3;7;1;9|]= map (fun i -> 2*i-1) [|2;4;1;5|]);;

let init n f =
  let res = Array.make n 0 in
  for i = 0 to n-1 do
  res.(i) <- f i 
  done;
  res
;;
assert([|0;1;4;9;16|]= init 5 (fun i -> i*i));;

let to_liste t =
  let n = (Array.length t) in
  let d =  ref (t.(n-1)::[]) in
  for i=n-2 downto 0 do
    d := (t.(i)::!d)
  done;
  !d
;;
assert([1;2;3]=to_liste [|1;2;3|]);;

let of_list u =
  match u with
  | [] -> [||]
  | x::xs ->
    let n = List.length u in
    let t = Array.make n x in
    let rec aux v k =
      match v with
      | [] -> t
      | y::ys -> begin t.(k) <- y;
                        aux ys (k+1)
                        end in
    aux xs 1
;;
assert([|1;2;3|]=of_list [1;2;3]);;

(*Exo 4*)

let rec somme_list liste =
  match liste with
  |[] -> 0
  |x::xs -> x+ somme_list xs
;;
assert(somme_list[1;2;3;4]=10);;

let rec produit_list liste =
  match liste with
  |[] -> 1
  |x::xs -> x* produit_list xs
;;
assert(produit_list[1;2;3;4]=24);;

let rec applatit liste =
  match liste with
  |[] -> []
  |x::xs -> x@(applatit xs)
;;
assert([1;2;3]=applatit [[1];[2];[3]]);;

let max_liste liste =
  let rec aux v max =
    match v with
    | [] -> max
    | x::xs -> if x > max then aux xs x else aux xs max in
  aux liste min_int
;;
assert(min_int=max_liste []);;
assert(3=max_liste [1;2;3]);;

let rec reduction f liste b =
  match liste with
    |[] -> b
    |x::xs -> f x (reduction f xs b)
;;
assert(reduction (fun a b -> a+b) [] 3 = 3);;
assert(reduction (fun a b -> 2*a+b) [7;6;2;4] 2 = 40);;

let somme_reduit liste = reduction (+) liste 0;;
let produit_reduit liste = reduction ( * ) liste 1;;
let applatit_reduit liste = reduction (@) liste [];;
let max_liste_reduit liste = reduction max liste min_int;;

assert(somme_reduit[1;2;3;4]=10);;
assert(produit_reduit[1;2;3;4]=24);;
assert([1;2;3]=applatit_reduit [[1];[2];[3]]);;
assert(min_int=max_liste_reduit []);;
assert(3=max_liste_reduit [1;2;3]);;

(*Exo 5*)

let longeur liste = reduction (fun a b -> b+1) liste 0;;

assert(longeur [1;2;3;4;5;7;8;9;9;5] = 10);;

let variance liste =
  let moyenne liste = (reduction ( +. ) liste 0.) /. (float_of_int(longeur liste)) in
  let dif liste moyenne = List.map (fun a -> a -. moyenne) liste in
  let carre liste = List.map (fun a -> a*.a) liste in
  moyenne (carre (dif liste (moyenne liste)))
;;
assert(1. = variance [2.;4.]);;
assert(4.66666666666666696 = variance [2.;3.;7.]);;

let nb_occs x liste = reduction (fun a b -> if a = x then b+1 else b) liste 0;;

assert(nb_occs 1 [1;1;1;1;1;2;5;4;7] = 5);;
