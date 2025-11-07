(* Questions de cours *)

(* Une pile est une structure ayant 3 action empiler, dépiler, pile_est_vide
Empiler rajoute un elément en haut de la pile : O(1)
dépiler retire un élement du haut de la pile : O(1)
*)

(*Q1 : On se munit de 3 pile qui représente les pilones des tours de Hanoï
Soit p q r des pile :
Init : p = [1;...;n], q = [], r = []
Fin : p = [], q = [], r = [1;...;n]*)

(*Q2 : Pour n = 4 on utilisera cette suite d'opération :
a = dépiler p, empiler q a, dépiler p, empiler r a, a = dépiler q, empiler r a, a = dépiler p, empiler q a,
dépiler r, empiler p  a, a = dépiler r, empiler q a, a = dépiler p, empiler q a, a = dépiler p, empiler r a
.....*)

(*Q4 : nb de déplacement selon n : 2^n - n = MULT((2 nb_dep(n-1)+1)*)
(*Q5 : demo mq c'est optimal:
  - Pour déplacer le disque n, il faut déplacer les n-1 autre
  - Quand on déplace le disque n il suffit de le déplacer en 1 fois sur r
  - Il faut alors redéplacer les autre n-1 disque*)

(* Implémentation d'une pile et de l'algorithme des tours de Hanoï *)

type 'a pile = 'a list ref ;;

let nouvelle_pile () = ref [] ;;

let pile_est_vide p = (!p = []) ;;

let depiler p =
    match !p with
    | [] -> failwith "pile vide"
    | x::xs -> p := xs ; x
;;

let empiler x p =p := x::!p;;


(* Exercice des tours de Hanoi *)


let afficher_pile p = 
    let rec aux l = match l with
    | [] -> ()
    | x::q -> Printf.printf "%d " x; aux q in
    aux !p ; Printf.printf "\n";;
;;

let initialiser_hanoi n =
    let p = nouvelle_pile () in
    let q = nouvelle_pile () in
    let r = nouvelle_pile () in
    for i = n downto 1 do
        empiler i p
    done ;
    (p,q,r)
;;

let rec hanoi n p q r c =
    if n = 0 then
      ()
    else
        begin
            (*afficher_pile p ;
            afficher_pile q ;
            afficher_pile r;*)
            hanoi (n-1) p r q c ;
            let a = depiler p in
            empiler a r ;
            c := !c + 1 ;
            hanoi (n-1) q p r c
        end
;;
    
let test =
    let n = 20 in
    let (p,q,r) = initialiser_hanoi n in
    let c = ref 0 in
    hanoi n p q r c ;
    afficher_pile p ;
    afficher_pile q ;
    afficher_pile r;
    Printf.printf "Nombre de déplacements : %d\n" !c ;
;;