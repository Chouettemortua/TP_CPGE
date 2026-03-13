(*******************************************************************)
(*           Code compagnon associé à l'exercice B.                *)
(*                                                                 *)
(*  Vous devez modifier ce fichier et le code qu'il contient pour  *)
(*  résoudre l'exercice.                                           *)
(*******************************************************************)


type chaine = char list

(* Jeu de tests fourni correspondant à celui de la question 1 *)
let textes = ["aab"; "abab"; "abbbaa"; "babaa"; "aaaba"; "abbabba"]

(* Fonction à compléter pour la question 5 *)
let rec respecte_naif (motif:chaine) (texte:chaine) :bool =
  match motif, texte with
  |[], [] -> true
  |['*'], [] -> true
  |_, [] -> false
  |[], _ -> false
  |_ -> failwith "A compléter" (* compléter cette fonction en y ajoutant les cas pertinents *)
