(*Exo 1*)

(*Le type sur lequel on va bosser*)
type entier_etendu =
  | Moins_Inf
  | Entier of int
  | Plus_Inf
;;

(*Quelque valeur général pour nos test*)
let age = Entier 18;;
let annee = Entier 2024;;
let pos_inf = Plus_Inf;;
let neg_inf = Moins_Inf;;

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

(*Exo 2*)

type couleur =
  | Carreau
  | Coeur
  | Trefle
  | Pique
;;

type carte = (int*couleur);;

let ace, valet, dame, roi = 1, 11, 12, 13;;

let cesar:carte = (roi, Carreau);;
let judith:carte = (dame, Coeur);;
let lancelot:carte = (valet, Trefle);;
let as_de_pique:carte = (ace, Pique);;
let sept_qui_prend:carte = (7, Carreau);;

let string_of_val x = 
  match x with
  |1 -> "As"
  |11 -> "Valet"
  |12 -> "Dame"
  |13 -> "Roi"
  |_ -> string_of_int x;;
let string_of_couleur x =
  match x with
  | Carreau -> "Carreau"
  | Coeur -> "Coeur"
  | Trefle -> "Trefle"
  | Pique -> "Pique"
;;
let affiche_carte (x:carte)=
  match x with
  |(v, c) -> print_string((string_of_val(v)^" de "^string_of_couleur(c)))
;;
affiche_carte cesar;;

(*Exo 3*)

(*Exo 4*)

(*Type Unaire*)
type entier_unaire =
  | Zero
  | Successeur of entier_unaire
;;

(*QQ variable*)
let zero = Zero;;
let un = Successeur zero;;
let deux = Successeur un;;
let trois = Successeur deux;;

(*Type Unaire to type int*)
let rec int_of_entier_unaire x =
  match x with
  | Zero -> 0
  | Successeur a -> 1 + int_of_entier_unaire a
;;
assert(2=int_of_entier_unaire deux);;
assert(3=int_of_entier_unaire trois);;

(*Type int to type Unaire*)
let rec entier_unaire_of_int x =
  match x with
  |0 -> Zero
  |a -> Successeur (entier_unaire_of_int (a-1))
;;
assert(Successeur (Successeur (Successeur Zero))=entier_unaire_of_int 3);;

(*Une boucle de test*)
for n = 0 to 10 do
  assert(n=int_of_entier_unaire(entier_unaire_of_int(n)))
done;;

(*Addition Unaire*)
let rec somme_unaire x y=
  match x, y with
  | x, Zero -> x
  | Zero, y -> y
  | x, Successeur z -> somme_unaire (Successeur x) z
;;
assert(5=int_of_entier_unaire(somme_unaire deux trois));;


let rec produit_unaire x y=
  match x, y with
  |x, Zero -> Zero
  |Zero, y -> Zero
  |x, Successeur z -> somme_unaire x (produit_unaire x z)
;;

assert(4=int_of_entier_unaire(produit_unaire deux deux));;

let rec puissance_unaire_naif x y=
  match x, y with
  |x, Zero -> Successeur Zero
  |x, Successeur z -> produit_unaire x (puissance_unaire_naif x z)
;;

assert(4=int_of_entier_unaire(puissance_unaire_naif deux deux));;



