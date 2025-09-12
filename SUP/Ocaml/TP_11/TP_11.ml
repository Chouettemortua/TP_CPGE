type 'a file_fonc = 'a list * 'a list ;;
let file_vide =([],[]);;

(*exo 1*)

let miroir u =
  let rec aux v acc =
    match v with
    |[] -> acc
    |x::xs -> aux xs (x::acc) in 
  aux u []
;;

miroir [1;2;4;5;7];;

let ajoute (u,v) x = ((x::u),v);;

let rec enleve (u,v)  =
  match v with
  |[] -> 
    if u <> [] then
      enleve ([], miroir u)
    else None
  |x::xs -> Some(x,(u,xs))
;;

(*exo 2*)

let rec somme u =
  match (enleve u) with
  |None -> 0
  |Some(x ,xs) -> x+(somme xs)
;;

let file_fonc_of_list u =
  let res = file_vide in
  let rec aux v res =
    match v with
    |[] -> res
    |x::xs -> aux xs (ajoute res x)  in
  aux (miroir u) res
;;  

let file_fonc_of_list_eff u =(u,[]) ;;

let rec itere_file f u =
  match (enleve u) with
  |None-> ()
  |Some(x ,xs)-> f x ; (itere_file f xs)
;;

let afficher u =
  itere_file (fun x -> print_int(x); 
  print_newline()) u
;;