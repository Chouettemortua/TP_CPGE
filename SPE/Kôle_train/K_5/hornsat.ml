(*Types décrit par l'énoncé*)
type clause_horn = int option * int list
type formule_horn = clause_horn list

let f1 = [(None, [0;1;3]); (Some 0, [1]); (Some 0, [2;3]); (Some 2, [0;3]); (Some 2, []); (None, [2;3])]
let f3 = [(None, [1;4]); (Some 1, []); (None, [0;3;4]); (Some 0, [1]); (Some 2, [3;4]); (Some 4, [0;1])]


(*Q1)
F1 est une formule de Horn car chaque clause a au plus un littéral positif.
F2 n'est pas une formule de Horn car la clause  (x1 ∨ ¬x1 ∨ x0) contient deux littéraux positifs (x1 et x0).
F3 est une formule de Horn car chaque clause a au plus un littéral positif.
*)

(*Q2 avoir_clause_vide : formule_horn -> bool*)
let rec avoir_clause_vide (f: formule_horn) : bool =
  match f with
  | [] -> false
  | (None, []) :: _ -> true
  | _ :: t -> avoir_clause_vide t
;;

(*Q3) determiner si les formules de q1 sont satisfiables.

F1 = (¬x0 ∨ ¬x1 ∨ ¬x3) ∧ (x0 ∨ ¬x1) ∧ (¬x2 ∨ x0 ∨ ¬x3) ∧ (¬x0 ∨ ¬x3 ∨ x2) ∧ x2 ∧ (¬x3 ∨ ¬x2)
on propage x2 = true dans les autres clauses:
(¬x0 ∨ ¬x1 ∨ ¬x3) ∧ (x0 ∨ ¬x1) ∧ (x0 ∨ ¬x3) ∧ (¬x3)
il reste que des clause non unitaire, donc F1 est satisfiable.

on fait de même pour F3:
F3 = (¬x1 ∨ ¬x4) ∧ x1 ∧ (¬x0 ∨ ¬x3 ∨ ¬x4) ∧ (x0 ∨ ¬x1) ∧ (x2 ∨ ¬x3 ∨ ¬x4) ∧ (x4 ∨ ¬x0 ∨ ¬x1)
on propage x1 = true:
(¬x4) ∧ (¬x0 ∨ ¬x3 ∨ ¬x4) ∧ (x0) ∧ (x2 ∨ ¬x3 ∨ ¬x4) ∧ (x4 ∨ ¬x0)
on propage x0 = true:
(¬x4) ∧ (¬x3 ∨ ¬x4) ∧ (x2 ∨ ¬x3 ∨ ¬x4) ∧ (x4)
on propage x4 = true:
() ∧ (¬x3) ∧ (x2 ∨ ¬x3)
F3 est pas satisfiable on a une clause vide qui est crée.
*)

(*Q4) trouver_clause_unitaire : formule_horn -> int option*)
let rec trouver_clause_unitaire (f: formule_horn) : int option =
  match f with
  | [] -> None
  | (Some x, []) :: _ -> Some x
  | _ :: t -> trouver_clause_unitaire t
;;

(*Q5) Justification que propager dans une formule de Horn donne une formule de Horn:
Cas de base: si la formule est vide, elle est de Horn et propager ne change rien.
Cas inductif: supposons que f est une formule de Horn. Lorsqu'on propage une variable x:
- Si une clause contient x, elle est satisfaite et peut être supprimée.
- Si une clause contient ¬x, on enlève ¬x de cette clause.
Dans les deux cas, le nombre de littéraux positifs dans chaque clause ne peut pas augmenter car on ne fait que supprimer des littéraux. 
Donc, la formule résultante reste une formule de Horn.

écrire la fonction propager : formule_horn -> int -> formule_horn*)

let rec propager (f: formule_horn) (x: int) : formule_horn =
  match f with
  | [] -> []
  | (Some y, neg) :: t when y = x -> propager t x
  | (pos, neg) :: t -> 
      let new_neg = List.filter (fun z -> z <> x) neg in
      (pos, new_neg) :: propager t x
;;

(*Q6) etre_satisfiable : formule_horn -> bool*)
let rec etre_satisfiable (f: formule_horn) : bool =
  if avoir_clause_vide f then
    false
  else
    match trouver_clause_unitaire f with
    | None -> true
    | Some x -> etre_satisfiable (propager f x)
;;

(*Tests*)

assert (etre_satisfiable f1 = true);;
assert (etre_satisfiable f3 = false);;

(*Q7) analyse de la complexité de etre_satisfiable
On parcout une première fois la formule pour vérifier la présence d'une clause vide, ce qui prend O(n) où n est le nombre de clauses.
Puis soit on a trouver une clause vide et on retourne false, soit on cherche une clause unitaire, ce qui prend aussi O(n).
Si on trouve une clause unitaire, on propage cette variable dans la formule, ce qui prend O(n*m) où m est le nombre moyen de littéraux par clause 
et supprime une clause et des litéraux. 
Donc on a une complexité de O(n)+O(n)+O(n*m) = O(n*m) pour chaque appel récursif avec n qui diminue à chaque appel m va aussi diminuer.
Donc au pire des cas on a n appels récursifs, avec des appels de complexité O(n*m).
Donc la complexité totale est O(n^2 * m).

HORN-SAT est dans P car on a trouvé un algorithme polynomial pour le résoudre.
alors que SAT est NP-complet, donc HORN-SAT est un sous-ensemble de SAT qui est plus facile à résoudre.
*)
