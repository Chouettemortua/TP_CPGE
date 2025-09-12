(** Squelette programme quine.ml pour TP 37 sur l'algorithme de Quine
  * Jeudi 22 juin 2025
*)

(*****************************************)
(** Algorithme en force brute pour SAT. **)
(*****************************************)

(** Formules logiques *)
type formule =
  | C of bool
  | V of int
  | Et of formule * formule
  | Ou of formule * formule
  | Imp of formule * formule
  | Non of formule
;;

type valuation = bool array;;

(** Taille d'une formule *)
let rec taille (f : formule) : int =
  match f with
  | C v -> 1
  | V v -> 1
  | Et (f1,f2) 
  | Ou (f1,f2) 
  | Imp (f1,f2) -> 1 + taille f1 + taille f2
  | Non f1 -> 1 + taille f1
;;

(** Indice maximal d'une variable dans une formule *)
let rec var_max (f : formule) : int =
  match f with
  | C v -> -1
  | V v -> v
  | Et (f1,f2)
  | Ou (f1,f2)
  | Imp (f1,f2) -> max(var_max f1) (var_max f2)
  | Non f1 -> var_max f1
;;

(** Évaluation d'une formule *)
let rec evalue (f : formule) (valu: valuation) : bool =
  match f with
  | C v -> v
  | V v -> valu.(v)
  | Et (f1,f2) -> (evalue f1 valu) && (evalue f2 valu)
  | Ou (f1,f2) -> (evalue f1 valu) || (evalue f2 valu)
  | Imp (f1,f2) -> not (evalue f1 valu) || (evalue f2 valu) 
  | Non f1 -> evalue f1 valu
;;

(** Exception Derniere déclenchée par incremente_valuation *)
exception Derniere;;

(** Prochaine valuation dans l'ordre de la numérotation par les entiers *)
let rec incremente_valuation (v : valuation) : unit =
  let n = Array.length v in
  let i = ref 0 in
  while !i < n do
    if v.(!i) then 
      begin
        if !i = n-1 then raise Derniere
        else v.(!i) <- false
      end
    else
      v.(!i) <- true;
    i := !i+1
  done;
;;

let satisfiable_brute (f : formule) : bool =
  let n = var_max f in
  let valu = Array.make n false in
  let test = ref (evalue f valu) in
  while not !test do
    incremente_valuation valu;
    test := (evalue f valu)
  done;
  !test
;;


(*************************)
(** Algorithme de Quine **)
(*************************)

(** Élimination des constantes *)
let rec elimine_constantes (f : formule) : formule =
  match f with
  | C v -> C v 
  | V v -> V v 
  | Et (f1,f2) -> 
    begin
      match (elimine_constantes f1), (elimine_constantes f2) with
      | C v, f2bis -> 
          if v then f2bis
          else C v
      | f1bis, C v -> 
        if v then f1bis
        else C v
      | f1bis, f2bis -> Et (f1bis, f2bis)
    end
  | Ou (f1,f2) -> 
    begin
      match (elimine_constantes f1), (elimine_constantes f2) with
      | C v, f2bis -> 
        if v then C v
        else f2bis
      | f1bis, C v ->
        if v then C v
        else f1bis
      | f1bis, f2bis -> Ou (f1bis, f2bis)
    end
  | Imp (f1,f2) -> elimine_constantes(Ou(Non(f1),f2))
  | Non f1 -> 
    begin
      match elimine_constantes f1 with
      |C v -> C (not v)
      |f1bis -> Non(f1bis)
    end
;;

(** Substitution *)
let rec substitue (f : formule) (i : int) (g : formule) : formule =
  match f with
  | C v -> C v
  | V v -> if v = i then g else V v
  | Et (f1,f2) -> Et((substitue f1 i g), (substitue f2 i g))
  | Ou (f1,f2) ->  Ou((substitue f1 i g), (substitue f2 i g))
  | Imp (f1,f2) ->  Imp((substitue f1 i g), (substitue f2 i g))
  | Non f1 -> Non((substitue f1 i g))
;;

(** Trois variables. *)
let x0 : formule = V 0
and x1 : formule = V 1
and x2 : formule = V 2
;;

(** Et une formule. *)
let f : formule = Et(
  Imp(x0,
    Et(x1,
      Ou(Non x0, x2)
    )
  ),
  Non(Et(x0, x2))
);;

let g1 : formule = elimine_constantes (substitue f 0 (C true));;
let g2 : formule = elimine_constantes (substitue f 0 (C false));;

(** Un arbre de décision utilisé par l'algorithme de Quine. *)
type decision =
  | Feuille of bool
  | Noeud of int * decision * decision
;;

(** Construire l'arbre. *)
let rec construire_arbre (f : formule) : decision =
  failwith "TODO: écrire cette fonction !"
;;

(** Satisfiabilité d'une formule, décidée par son arbre de Quine. *)
let satisfiable_via_arbre (f : formule) : bool =
  failwith "TODO: écrire cette fonction !"
;;


(**************************************************************)
(** Un exemple d'application : le coloriage de graphes **)
(**************************************************************)

type graphe = int list array ;;

(* Graphe de Petersen : nombre chromatique égal à 3. *)
let petersen : graphe =
  [|
    [4; 5; 6];
    [6; 7; 8];
    [5; 8; 9];
    [4; 7; 9];
    [0; 3; 8];
    [0; 2; 7];
    [0; 1; 9];
    [1; 3; 5];
    [1; 2; 4];
    [2; 3; 6]
  |]
;;

(* Générateur de graphe aléatoire.
 * selon le modèle de Erdös-Renyi :
 * graphe_alea n p génère un graphe à n sommet
 * dans lequel chaque arête possible a une probabilité p
 * d'être choisie (indépendamment des autres). *)

let graphe_alea (n : int) (proba_arete : float) : graphe =
  let g = Array.make n [] in
  for i = 0 to n - 1 do
    for j = i + 1 to n - 1 do
      if Random.float 1. <= proba_arete then begin
        g.(i) <- j :: g.(i);
        g.(j) <- i :: g.(j)
      end
    done
  done;
  g
;;

(** Encodage du problème de la k-coloration de ce graphe dans une formule à SAT-isfaire. *)
let encode (g : graphe) (k : int) : formule =
  failwith "TODO: écrire cette fonction !"
;;

(** Est-ce que le graphe g est k-coloriable, en utilisant l'algorithme de Quine. *)
let est_k_coloriable (g : graphe) (k : int) : bool =
  failwith "TODO: écrire cette fonction !"
;;

(** Calcul du nombre chromatique de g, par la méthode que vous voulez (itérative exhaustive, dichotomie, etc). *)
let chromatique (g : graphe) : int =
  failwith "TODO: écrire cette fonction !"
;;


(** Lecture d'un graphe au format DIMACS. *)
let lire_dimacs (path : string) : graphe =
  failwith "TODO: écrire cette fonction !"
;;

(* chromatique (lire_dimacs "myciel3.col");; *)


(***************************)
(** Version plus efficace **)
(***************************)

let rec simplifie (i : int) (b : bool) (f : formule) : formule =
  failwith "TODO: écrire cette fonction !"
;;

let rec satisfiable (f : formule) : bool =
  failwith "TODO: écrire cette fonction !"
;;

(* chromatique (lire_dimacs "myciel4.col");; *)


(* chromatique (lire_dimacs "queen5_5.col");; *)
