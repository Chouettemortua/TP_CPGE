(*Le type sur lequel on va bosser*)
type entier_etendu =
  | Moins_Inf
  | Entier of int
  | Plus_Inf
;;

(*Quelque valeur général pour nos test*)
let age: entier_etendu = Entier 18;;
let annee: entier_etendu = Entier 2024;;
let pos_inf: entier_etendu = Plus_Inf;;
let neg_inf: entier_etendu = Moins_Inf;;

(*La fonct qui gère le + pour le Type*)
let ajoute_etendu x y =
  match x,y with
  | Moins_Inf, Plus_Inf -> failwith("cas indetermine +oo -oo")
  | Plus_Inf, Moins_Inf -> failwith("cas indetermine +oo -oo")
  | Moins_Inf, _ -> Moins_Inf
  | Plus_Inf, _ -> Plus_Inf
  | _,Moins_Inf -> Moins_Inf
  | _,Plus_Inf -> Plus_Inf
  |Entier a,Entier b -> Entier (a+b)
;;

(*Des Test*)
assert (Entier 2042=ajoute_etendu age  annee);;
assert (Moins_Inf=ajoute_etendu age  neg_inf);;
assert (Plus_Inf=ajoute_etendu age  pos_inf);;
assert (Moins_Inf=ajoute_etendu neg_inf  neg_inf);;
assert (Plus_Inf=ajoute_etendu pos_inf  pos_inf);;
ajoute_etendu pos_inf  neg_inf;;

(*Méthode produit pour le Type*)
let produit_etendu x y =
  match x,y with
  | Entier 0, _ -> Entier 0
  | _, Entier 0 -> Entier 0
  | Entier a, Entier b -> Entier (a*b)
  | Entier a, Plus_Inf -> if a > 0 then Plus_Inf else Moins_Inf
  | Plus_Inf, Entier a -> if a > 0 then Plus_Inf else Moins_Inf
  | Entier a, Moins_Inf -> if a < 0 then Plus_Inf else Moins_Inf
  | Moins_Inf, Entier a -> if a < 0 then Plus_Inf else Moins_Inf
  | Moins_Inf, Moins_Inf -> Plus_Inf
  | Moins_Inf, Plus_Inf -> Moins_Inf
  | Plus_Inf, Moins_Inf -> Moins_Inf
  | Plus_Inf, Plus_Inf -> Plus_Inf
;;

(*Test pour produit*)
assert (Entier (-20230) = produit_etendu (Entier (-10))  (Entier 2023));;
assert (Entier 20230 = produit_etendu (Entier 10)  (Entier 2023));;
assert (Entier 0 = produit_etendu Plus_Inf  (Entier 0));;
assert (Entier 0 = produit_etendu Moins_Inf  (Entier 0));;
assert (Plus_Inf=produit_etendu Plus_Inf Plus_Inf);;
assert (Moins_Inf=produit_etendu Moins_Inf Plus_Inf);;
assert (Moins_Inf=produit_etendu Plus_Inf Moins_Inf);;
assert (Plus_Inf=produit_etendu Moins_Inf Moins_Inf);;
