(** Squelette TP 05
    Introduction à l'Analyse d'Algorithmes.
 **)

(* Exercice 1 *)

let rec fib_naif n =
  if n <= 1 then n
  else fib_naif (n - 1) + fib_naif (n - 2)
;;
assert(55=fib_naif 10);;

(* Exercice 2 *)

let fib_iter n =
  let n_1 = ref 1 in
  let n_2 = ref 0 in
  if n <= 1 then n
  else
    begin
      for i=2 to n do
      (*n_1 c'est fib i*)
      (*n_2 c'est fib i-1*)
        let t = !n_1 in
        n_1 := !n_1+ !n_2;
        n_2 := t
      done;
      !n_1
    end
;;

let () =
  assert (fib_iter 2 = 1);
  assert(55=fib_iter 10)
;;

let fib_rec n =
  let rec aux i f1 f2 =
    if i <= 1 then 1
    else f1 + aux (i-1) f2 (f1+f2) in
  aux n 0 1
;;

let fib_rec_term n =
  let rec aux i f1 f2 =
    if i <= 1 then f2
    else aux (i-1) f2 (f1+f2) in
  aux n 0 1
;;

let () =
  assert(55 = fib_rec_term 10)
;;

(* Exercice 3 *)

let tri_decroissant u = List.sort (fun x y -> y-x) u ;;

let () =
  assert([8;7;6;5;4;3;2;1]= tri_decroissant [1;2;3;4;5;6;7;8]);
;;

let tri_valeur_absolue u = List.sort (fun x y -> int_of_float( (abs_float x) -. (abs_float y) )) u;;

let () =
  assert([1.;2.;3.;4.;5.;6.;7.;8.]= tri_valeur_absolue [1.;2.;3.;4.;5.;6.;7.;8.]);
;;

let tri_deuxieme_composante u =
  failwith "à faire"

let () =
  (* à compléter ! *)
  assert true
;;

(* Exercice 4 *)

let rec records cmp u =
  failwith "à faire"
;;

let () =
  assert (records compare [] = []);
  assert (records compare [4] = [4]);
  assert (records compare [4; 1; 3; 7; 5; 7; 6; 7; 10] = [4; 7; 10]);
  assert (records compare [4; 1; 3; 7; 5] = [4; 7]);
  let u = [1; 8; 2; 4; 5; 10; 4; 10; 11; 8] in
  assert (records (fun x y -> x - y) u = [1; 8; 10; 11]);
  let v = [(1, 3); (2, 2); (0, 5); (3, 1); (4, 3)] in
  let cmp (a, b) (c, d) = (a + b) - (c + d) in
  assert (records cmp v = [(1, 3); (0, 5); (4, 3)])
;;

(* Exercice 5 *)

let rec pgcd a b =
  if b = 0 then a else pgcd b (a mod b)
;;

let rec etapes a b =
  failwith "à faire"
;;

let () =
  assert (etapes 0 0 = 0);
  assert (etapes 12 0 = 0);
  assert (etapes 17 1 = 1);
  assert (etapes 15 6 = 2);
  assert (etapes 728 427 = 7);
  assert (etapes 34 21 = 7);
  (* assert (etapes 112233445566 223344556677 = 6) *)
  (* ne marche pas sur OCaml en ligne, les entiers sont trop petits *)
;;

let phi n =
  failwith "à faire"
;;

let () =
  assert (
    List.init 15 (fun i -> phi (i + 1))
    = [0; 1; 2; 2; 3; 2; 3; 4; 3; 3; 4; 4; 5; 4; 4]);
  assert (phi 12345 = 15)
;;

let records_euclide borne =
  failwith "à faire"
;;
