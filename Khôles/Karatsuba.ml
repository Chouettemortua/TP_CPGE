(*Version: 1.0*)
(*Description: Karatsuba Khôle 1*)

(*Q1) on a alors f0g0 + ((f0 + f1)(g0 + g1) - f0g0 - f1g1)X + f1g1 X^2 
  donc il y a 3/5 multiplication (selon si on compte les doublons) et 6 addition
*)

(*Q2) avec des F et G ainsi poser on a 
  H = FG = F0G0 + ((F0 + F1)(G0 + G1) - F0G0 - F1G1)X^k + F1G1 X^2k  
*)

(*Q3) On divise les polynôme en deux sous polynôme de taille n/2
      On calcule les 3 produits de taille n/2 qui ont un coût de K(n/2)
      On calcule ensuite des addition qui sont en O(n)
      Donc on a K(n)= 3K(n/2) + O(n)
                    = 3(3K(n/4) + O(n/2)) + O(n)
      Ainsi de suite aprés m itération on a K(n) = 3^m K(n/2^m) + O(n Sum(0<=i<=m-1)(3/2)^i)
      On a donc K(n) = O(n^log2(3)) 
      car n = 2k = 2^m et on aura m = log2(n) (on divise le deg par 2)
      et donc la somme et égale 2(n^log2(3)-1)-1 -> O(n^log2(3))
*)

(*Q6 les autre fonction (placer au dessus car utiliser par karatsuba)*)

let normalize p =
    let rec normalize_aux = 
      function
      | [] -> []
      | t::q -> t::normalize_aux q
    in
  normalize_aux p 
;;

let rec add p q =
  match p,q with
  | [],_ -> q
  | _,[] -> p
  | x::xs, y::ys -> (x+y)::(add xs ys)
;;

let rec substract p q =
  match p,q with
  | [],_ -> q
  | _,[] -> p
  | x::xs, y::ys -> (x-y)::(substract xs ys)
;;

let rec add_zeros p = 
  function
  | 0 -> p
  | k -> add_zeros (0::p) (k-1)
;;

let deg p =
  match p with
  | [] -> 0
  | _ -> List.length p - 1
;;

(*Q4 et Q5*)
let cut l k =
  let rec term_rec_cut acc l k =
    match k, l with
    | 0, _ -> List. rev acc, l
    | _, [] ->  List.rev acc, []
    | k, x::xs -> term_rec_cut (x::acc) xs (k-1)
    in
  term_rec_cut [ ] l k 
;;

let rec karatsuba f g = 
  match f,g with
  | [ ] ,_ | _,[ ] | [0], _ | _ ,[0] -> [0] (*pas utile mais acc\’el\‘ere*)
  | [a ], _ -> List.map (fun x -> x*a) g
  | _ ,[ b] -> List.map (fun x -> x*b) f
  | _ , _-> 

    let k = (1 + max (deg f) (deg g)) / 2 in
    let f0, f1 = cut f k in
    let g0, g1 = cut g k in

    let a1 = karatsuba f0 g0 in
    let a2 = karatsuba f1 g1 in
    let a3 = add f0 f1 in
    let a4 = add g0 g1 in
    let a5 = karatsuba a3 a4 in
    let a6 =  substract a5 a1 in
    let a7 = substract a6 a2 in

    add (add a1 (add_zeros a7 k)) (add_zeros a2 (2*k))
;;