type graphe = {nb_sommets:int; voisins: int -> int list}

exception Trouver of int array ;;

let hamiltonien_depuis (g : graphe) (x0 : int) =
  let ordre = Array.make g.nb_sommets x0 in
  let vu = Array.make g.nb_sommets false in

  let rec aux_recherche pos next =
    if pos = g.nb_sommets then raise (Trouver ordre);
    if not (vu.(next) || g.voisins next = []) then
      begin
        vu.(next) <- true;
        ordre.(pos) <- next;
        List.iter (aux_recherche (pos+1)) (g.voisins next);
        vu.(next) <- false;
      end
    in
  try
    aux_recherche 0 x0;
    None
  with
  | Trouver res -> Some res
;;

let v_test x =
  match x with
  | 0 -> [1]
  | 1 -> [2; 7]
  | 2 -> [1; 3; 5]
  | 3 -> [2; 4; 6]
  | 4 -> [3]
  | 5 -> [2; 8]
  | 6 -> [3; 7; 8]
  | 7 -> [1; 6]
  | 8 -> [5; 6]
;

let test = {nb_sommets = 9; voisins = v_test};;
hamiltonien_depuis test 0;;

let graphe_cavalier n m =
  let fonc_cavalier x =
    let res = ref [] in
    let possible = [|x-m*2-1;x-m*2+1;
    x+m*2-1;x+m*2+1;x-m-2;
    x-m+2;x+m-2;x+m+2;|] in
    let i = ref 0 in
    while !i < 8 do
      if possible.(!i)<n*m && 0<possible.(!i) then
        res := possible.(!i)::(!res);
      i := !i + 1;
      done;
    !res  
  in
  {nb_sommets = n*m; voisins = fonc_cavalier}
;;

let affiche_parcours_cavalier n m (x, y) =
  let parcours_pack = hamiltonien_depuis (graphe_cavalier n m) (x+y*m) in
  match parcours_pack with
  |None -> failwith "parcours impossible"
  |Some parcours ->
    let remise_ordre = Array.make (n*m) 0 in
    for i = 0 to ((n*m)-1) do
      remise_ordre.(parcours.(i)) <- i;
    done;
    for i = 0 to ((n*m)-1) do
      if i mod m = 0 then
        Printf.printf "\n";
      Printf.printf "%d " remise_ordre.(i);
    done;
;;

affiche_parcours_cavalier 5 6 (0,1);;



  

