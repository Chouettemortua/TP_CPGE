type entier_etendu =
  | Moins_Inf
  | Entier of int
  | Plus_Inf
;;

let age: entier_etendu = Entier 18;;
let annee: entier_etendu = Entier 2024;;
let pos_inf: entier_etendu = Plus_Inf;;
let neg_inf: entier_etendu = Moins_Inf;;

let ajoute_etendu x y =
  match x,y with
  | Moins_Inf, Plus_Inf -> failwith("cas indeter")
  | Plus_Inf, Moins_Inf -> failwith("cas indeter")
  | Moins_Inf, _ -> Moins_Inf
  | Plus_Inf, _ -> Plus_Inf
  | _, Moins_Inf -> Moins_Inf
  | _, Plus_Inf -> Plus_Inf
  |Entier a,Entier b -> Entier (a+b)
;;