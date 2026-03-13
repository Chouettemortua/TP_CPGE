(* entrée : un k-gramme sous forme de string array, donc une liste de k mots *)
(* sortie : couple, avec dictionnaire d'occurrences des prochain mot/string, et référence indiquant le nombre d'occurrence de chaque k-gramme  *)
type texte = string array
type modele = (* A COMPLETER *)

let _ = Random.self_init()

(* sera utilisé pour les tests, bien plus tard *)
let renaud = [|"amoureux-de-paname.txt" ; "societe-tu-m-auras-pas.txt" |]



(** fonctions d'affichage **)

(* écrit le texte donné en entrée dans le flux f *)
let fprint_text f (txt : texte) = Array.iter (fun s -> Printf.fprintf f "%s%!" s) txt

(* écrit le dictionnaire h des occurrences des successeurs de du texte str dans le flux f *)
let fprint_dictionnaire_occurrence f h str =

    (* ENCAPSULER LE CODE CI-DESSOUS POUR QU'IL SOIT APPLIQUE A TOUT LE DICTIONNAIRE h *)
    (* 
    Printf.fprintf f "\"%s\" apparaît %d fois comme successeur de \"" s m ;
    fprint_text f str ;
    Printf.fprintf f "\".\n%!"
    *)
    ()

(* écrit, pour chaque N-gramme dans le modèle m, son nombre d'occurrences, et son dictionnaire d'occurrence, dans le flux f *)
let fprint_modele f m =
  (* ENCAPSULER LE CODE CI-DESSOUS POUR QU'IL SOIT APPLIQUE A TOUT LE MODELE m *)
    (*
    Printf.fprintf f "Le %d-gramme \"" (Array.length str) ; 
    fprint_text f str ; Printf.fprintf f "\"apparaît %d fois, et voici ses successeurs :\n" !occ ; 
    (* A COMPLETER *) ; Printf.fprintf f "\n%!"
    *)
    ()
