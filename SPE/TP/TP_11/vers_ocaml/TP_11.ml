
let objectif = ref 0;;
let compteur = ref 0;;
let m = Mutex.create();;

let puissance a n =
  let rec aux a n acc =
    if n = 0 then acc
    else aux a (n - 1) (acc * a)
  in
  aux a n 1
;;

let f () =
  for i = 1 to !objectif do
    Mutex.lock m;
    compteur := !compteur + 1;
    Mutex.unlock m
  done;
  Thread.exit ()
;;

let g () =
  let local_compteur = ref 0 in
  for i = 1 to !objectif do
    local_compteur := !local_compteur + 1
  done;
  Mutex.lock m;
  compteur := !compteur + !local_compteur;
  Mutex.unlock m;
  Thread.exit ()
;;

let main () =
  let nb_threads = 4 in 
  objectif := puissance 2 30;
  Printf.printf "Objectif par thread : %d\n" !objectif;

  (* Utilisation de la fonction f ou g (a modif en brut) *)
  compteur := 0;
  let threads = Array.init nb_threads (fun _ -> Thread.create g ()) in
  Array.iter Thread.join threads;
  Printf.printf "Compteur final: %d\n" !compteur;
;;
main ();;