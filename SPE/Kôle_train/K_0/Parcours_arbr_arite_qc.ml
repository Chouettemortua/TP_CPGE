(*Parcours d'arbre d'arité quelconque*)
(*Implem*)

type 'a arbre_bin = Vide | Noeud of 'a arbre_bin * 'a * 'a arbre_bin ;;

(*O(n)*)
let rec parcours_prefixe_binaire (a : int arbre_bin): unit =
    match a with
    | Vide -> ()
    | Noeud (g, v, d) -> Printf.printf "|%d" v; parcours_prefixe_binaire g; parcours_prefixe_binaire d
;;

type 'a arbre = Vide | Noeud of 'a * 'a arbre list ;;

(*O(a*n)*)
let rec parcours_prefixe (a : int arbre): unit =
    match a with
    | Vide -> ()
    | Noeud (v, l) -> Printf.printf "|%d" v; List.iter parcours_prefixe l
;;

let rec arite (a : 'a arbre) : int =
    match a with
    | Vide -> 0
    | Noeud (v, l) -> List.fold_left (fun acc x -> max acc (arite x)) (List.length l) l

let abr = Noeud (1, [Noeud (2, [Noeud (4, []); Noeud (5, [])]); Noeud (3, [Noeud (6, []); Noeud (7, [])])]) ;;
Printf.printf "\nParcours prefixe : " ;;
parcours_prefixe abr ;;
Printf.printf "\n" ;;
Printf.printf "Arite : %d\n" (arite abr) ;;