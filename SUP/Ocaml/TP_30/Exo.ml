
let sac p v pmax =
  let rec f k d =
    if k<0 || d<=0 then 0
    else
      let d' = d-p.(k) in
      if d'>=0 then max (v.(k) + f (k-1) d') (f (k-1) d)
      else f (k-1) d
    in
  
  f (Array.length p-1) pmax
;;

let sac_instrument p v pmax =
  let c = ref 0 in
  let rec f k d=
    c := !c+1;
    if k<0 || d<=0 then 0
    else
      let d' = d-p.(k) in
      if d'>=0 then max (v.(k) + f (k-1) d') (f (k-1) d)
      else f (k-1) d
    in
  
  f (Array.length p-1) pmax;
  !c
;;

let sac_mem p v pmax =
  let mem = Array.make_matrix (Array.length p) pmax -1 in
  let rec f k d=
    if mem.(k).(d) = -1 then
      if k<0 || d<=0 then 0
      else
        let d' = d-p.(k) in
        if d'>=0 then 
          mem.(k).(d) = max (v.(k) + f (k-1) d') (f (k-1) d);
          mem.(k).(d)
        else 
          mem.(k).(d) = f (k-1) d;
          mem.(k).(d)
    else mem.(k).(d)
    in
  
  f (Array.length p-1) pmax
;;

sac [|10; 5; 3; 2; 1|] [|50; 10; 7; 100; 5|] 20;;


let p_ex = [|3; 8; 5; 1; 6; 1; 2; 6; 6; 1; 7; 8; 9; 12; 4; 1; 5; 7; 11; 4; 1; 5; 12; 13|];;
let v_ex = [|1; 2; 6; 3; 7; 8; 2; 3; 4; 7; 5; 2; 12; 8; 5; 3; 7; 10; 8; 7; 4; 15; 7; 20|];;

sac_instrument p_ex v_ex 100;;