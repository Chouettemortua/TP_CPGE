
type point = {x : float; y : float}


let distance p1 p2 =
  sqrt( (p1.x -. p2.x)**2. +. (p1.y -. p2.y)**2. )
;;


let dmin_naif arr =
  let len = Array.length arr in
  let min = ref infinity in
  for i = 0 to len-1
  do
    for j = i+1 to len-1
    do
      let d = distance arr.(i) arr.(j) in  
      if d < !min then min := d;
    done;
  done;
  !min
;;

dmin_naif [|{x=1.;y=8.};{x=1.;y=3.};{x=5.;y=6.};{x=6.;y=7.}|];;

let separe_moitie l =
  let len = List.length l in
  let d = ref [] in
  let g = ref [] in
  for i = 0 to len do
    match l with
    |[] -> d,g
    |x::xs when i<= len/2 -1 -> 
      l = xs;
      g := x::!g;
    |x::xs ->
      l = xs;
      d := x::!d;
    done;
  !d,!g ;
;;


let compare_x p1 p2 =
  if p1.x < p2.x then -1
  else if p1.x = p2.x then 0
  else 1
;;

let tri_par_x liste = List.sort compare_x liste;;

tri_par_x [{x=1.;y=8.};{x=1.;y=3.};{x=5.;y=6.};{x=6.;y=7.}];;

let rec dmin_gauche_droite l1 l2 =
  let l1 = Array.of_list l1 in
  let l2 = Array.of_list l2 in
  let min = ref infinity in
  for i=0 to Array.length l1 do
    for j=0 to Array.length l2 do
      let d = distance l1.(i) l2.(j) in
      if d < !min then
        min := d
    done;
  done;
  !min
;;
      

let rec dmin_dc arr =
  let len = Array.length arr in
  if len > 2 then 
      let d,g = separe_moitie (Array.to_list arr) in
      let dg = dmin_dc (Array.of_list g)  in
      let dd = dmin_dc (Array.of_list d) in
      let d = dmin_gauche_droite d g in
      min d (min dg dd);
  else 
    if len = 2 then 
      distance arr.(0) arr.(1)
    else
      infinity
;;

dmin_dc [|{x=1.;y=8.};{x=1.;y=3.};{x=5.;y=6.};{x=6.;y=7.}|];;