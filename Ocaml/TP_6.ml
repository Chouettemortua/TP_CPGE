(**********************************)
(*            Exercice 1          *)
(**********************************)

let cherche_dicho t x =
  let rec aux deb fin =
    if deb >= fin then None
    else
      let mil = (deb+fin)/2 in
      if t.(mil) = x then Some mil 
      else 
        if t.(mil) < x then aux (mil+1) fin
        else aux deb mil in
  aux 0 (Array.length t)
;;


let teste_cherche_dicho () =
  assert (cherche_dicho [| |] 3 = None);
  let t = [|1; 3; 5; 7; 9; 11|] in
  (* a_chercher = [0; 1; ...; 12] *)
  let a_chercher = List.init 13 (fun i -> i) in
  let resultats = List.map (cherche_dicho t) a_chercher in
  assert (resultats =
          [None; Some 0; None; Some 1; None; Some 2;
           None; Some 3; None; Some 4; None; Some 5; None])
;;

teste_cherche_dicho ();;


(**********************************)
(*            Exercice 6          *)
(**********************************)

let rec insertion x u =
  match u with
  |[] -> [x]
  |y::ys -> if x<y then x::y::ys else y:: (insertion x ys)
;;


let teste_insertion () =
  assert (insertion 3 [] = [3]);
  assert (insertion 0 [2; 4] = [0; 2; 4]);
  assert (insertion 3 [1; 4; 5] = [1; 3; 4; 5]);
  assert (insertion 5 [1; 2; 4] = [1; 2; 4; 5]);
  assert (insertion 3 [1; 2; 3; 6] = [1; 2; 3; 3; 6])
;;
teste_insertion();;

let rec tri_insertion u =
  match u with
  |[] -> []
  |x::xs -> insertion x (tri_insertion xs)
;;

let teste_tri_insertion () =
  assert (tri_insertion [] = []);
  assert (tri_insertion [1] = [1]);
  assert (tri_insertion [1; 2; 3] = [1; 2; 3]);
  assert (tri_insertion [2; 3; 1] = [1; 2; 3]);
  assert (tri_insertion [4; 1; 5; 3; 2] = [1; 2; 3; 4; 5])
;;
teste_tri_insertion ();;

(**********************************)
(*            Exercice 7          *)
(**********************************)

let echange t i j =
  let s = t.(i) in
  t.(i) <- t.(j);
  t.(j) <- s
;;

let insertion_en_place t i =
  let j = ref (i-1) in
  while !j >= 0 do
    if t.(!j) < t.((!j+1)) then j:= -1
    else 
      begin
        echange t !j (!j+1);
        j := !j-1
      end;
  done
;;

let teste_insertion_en_place () =
  let teste t i t' =
    insertion_en_place t i;
    t = t' in
  assert (teste [|3; 5; 7; 2; 3|] 2 [|3; 5; 7; 2; 3|]);
  assert (teste [|3; 5; 7; 2; 3|] 3 [|2; 3; 5; 7; 3|]);
  assert (teste [|3; 5; 7; 3; 3|] 3 [|3; 3; 5; 7; 3|]);
  assert (teste [|3; 5; 7; 4; 3|] 3 [|3; 4; 5; 7; 3|]);
  assert (teste [|3; 5; 7; 6; 3|] 3 [|3; 5; 6; 7; 3|]);
  assert (teste [|3; 5; 7; 9; 3|] 3 [|3; 5; 7; 9; 3|]);
  assert (teste [|2; 3; 5; 7; 1|] 4 [|1; 2; 3; 5; 7|]);
  assert (teste [|2; 3; 5; 7; 5|] 4 [|2; 3; 5; 5; 7|]);
  assert (teste [|2; 3; 5; 7; 8|] 4 [|2; 3; 5; 7; 8|])
;;
teste_insertion_en_place ();;

let tri_insertion_tableau t =
  for i=1 to (Array.length t)-1 do
    insertion_en_place t i
  done
;;

let teste_tri_insertion_tableau () =
  let teste t =
    let t' = Array.copy t in
    tri_insertion_tableau t;
    Array.sort compare t';
    t = t' in
  assert (teste [||]);
  assert (teste [|1|]);
  assert (teste [|1; 2|]);
  assert (teste [|2; 1|]);
  assert (teste [|1; 2; 3|]);
  assert (teste [|3; 2; 1|]);
  assert (teste [|5; 1; 2; 1; 4; 2; 1; 7; 3; 0|]);
  let t = Array.init 500 (fun i -> Random.int 500) in
  assert (teste t)
;;
teste_tri_insertion_tableau ();;

let insertion_en_place_bis t i =
  let j = ref (i-1) in
  let s = t.(!j+1) in
  while !j >= 0 &&  t.(!j) > s  do
    t.(!j+1) <- t.(!j);
    j := !j-1
  done;
  t.(!j+1) <- s
;;

let teste_insertion_en_place_bis () =
  let teste t i t' =
    insertion_en_place_bis t i;
    t = t' in
  assert (teste [|3; 5; 7; 2; 3|] 2 [|3; 5; 7; 2; 3|]);
  assert (teste [|3; 5; 7; 2; 3|] 3 [|2; 3; 5; 7; 3|]);
  assert (teste [|3; 5; 7; 3; 3|] 3 [|3; 3; 5; 7; 3|]);
  assert (teste [|3; 5; 7; 4; 3|] 3 [|3; 4; 5; 7; 3|]);
  assert (teste [|3; 5; 7; 6; 3|] 3 [|3; 5; 6; 7; 3|]);
  assert (teste [|3; 5; 7; 9; 3|] 3 [|3; 5; 7; 9; 3|]);
  assert (teste [|2; 3; 5; 7; 1|] 4 [|1; 2; 3; 5; 7|]);
  assert (teste [|2; 3; 5; 7; 5|] 4 [|2; 3; 5; 5; 7|]);
  assert (teste [|2; 3; 5; 7; 8|] 4 [|2; 3; 5; 7; 8|])
;;

teste_insertion_en_place_bis ();;

let tri_insertion_tableau_bis t =
  for i=1 to (Array.length t)-1 do
    insertion_en_place_bis t i
  done
;;


let teste_tri_insertion_tableau_bis () =
  let teste t =
    let t' = Array.copy t in
    tri_insertion_tableau_bis t;
    Array.sort compare t';
    t = t' in
  assert (teste [||]);
  assert (teste [|1|]);
  assert (teste [|1; 2|]);
  assert (teste [|2; 1|]);
  assert (teste [|1; 2; 3|]);
  assert (teste [|3; 2; 1|]);
  assert (teste [|5; 1; 2; 1; 4; 2; 1; 7; 3; 0|]);
  let t = Array.init 500 (fun i -> Random.int 500) in
  assert (teste t)
;;
teste_tri_insertion_tableau_bis ();;

(**********************************)
(*            Exercice 8          *)
(**********************************)

let rec eclate u =
  match u with
  |[] -> ([],[])
  |[x] -> ([], [x])
  |[x;y] -> ([x],[y])
  |x::y::xs -> let g,d = eclate xs in
              (x::g, y::d)
;;

let rec fusionne u v =
  match u , v with
  |u,[] -> u
  |[],v -> v
  |x::xs,y::ys -> 
    if x<y then x::(fusionne xs v)
    else y::(fusionne u ys)
;;

let rec tri_fusion u =
  match u with
  |[] -> []
  |[x]->[x]
  |x::xs-> 
    let g,d = eclate u in
    fusionne (tri_fusion g) (tri_fusion d)
;;

let teste_tri_fusion () =
  assert (tri_fusion [] = []);
  assert (tri_fusion [3] = [3]);
  assert (tri_fusion [1; 2] = [1; 2]);
  assert (tri_fusion [1; 1] = [1; 1]);
  assert (tri_fusion [2; 1] = [1; 2]);
  assert (tri_fusion [5; 0; 2; 5; 1; 2; 3; 7; -1]
          = [-1; 0; 1; 2; 2; 3; 5; 5; 7]);
  let u = List.init 10_000 (fun i -> Random.int 10_000) in
  assert (tri_fusion u = List.sort compare u)
;;
teste_tri_fusion ();;

let nb_occs_trie t i =
  failwith "not implemented"
;;

let nb_occs_naif t x =
  let counter = ref 0 in
  for i = 0 to Array.length t - 1 do
    if t.(i) = x then incr counter
  done;
  !counter
;;

let teste_nb_occs () =
  let t = Array.init 10000 (fun i -> Random.int 100) in
  Array.sort compare t;
  for i = -1 to 100 do
    assert (nb_occs_trie t i = nb_occs_naif t i)
  done
;;
