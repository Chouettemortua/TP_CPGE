(*TP 4*)

(*Exo 1*)

let extrema t =
  let min = ref t.(0) in
  let max = ref t.(0) in
  let n = Array.length t in
  for i = 1 to n-1 do
    if t.(i) < !min then
      min := t.(i);
    if t.(i) > !max then
      max := t.(i)
  done;
  (!min, !max)
;;
assert((1,4)=extrema [|1;2;3;4|]);;

let nb_occs x t =
  let occ = ref 0 in
  for i = 0 to (Array.length t)-1 do
    if t.(i) = x then
      occ := !occ+1
  done;
  !occ
;;
assert(2=nb_occs 1 [|1;2;3;1|]);;

let tab_occs t =
  let n = (Array.length t) in
  let res = Array.make n 0 in
  for i = 0 to n-1 do
    res.(i) <- nb_occs i t
  done;
  res
;;
assert([|1; 2; 1; 1; 0|]=tab_occs [|0;1;1;2;3|]);;

let tab_occs_eff t =
  let n = (Array.length t) in
  let res = Array.make n 0 in
  for i = 0 to n-1 do
    if t.(i) <= n then res.(t.(i)) <- res.(t.(i))+1
  done;
  res
;;
assert([|1; 2; 1; 1; 0|]=tab_occs_eff [|0;1;1;2;3|]);;

(*Exo 2*)