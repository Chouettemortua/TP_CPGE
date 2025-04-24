type sommet = int;;
type graphe = sommet list array;;

let dfs pre post g x0 =
  let n = Array.length g in
  let vus = Array.make n false in
  let rec explorer x =
    if not vus.(x) then
      begin
        vus.(x) <- true;
        pre x;
        List.iter (fun y -> explorer y) g.(x);
        post x;
      end
  in
  explorer x0;
;;

let ouvre x = Printf.printf "Ouverture %d\n" x;;
let ferme x = Printf.printf "Fermeture %d\n" x;;

let g0 = [|[1;2];[2;3;4];[];[0;5];
          [1;2];[10];[1;9];[8];[6];
          [7;10];[11];[5]|] ;;

dfs ouvre ferme g0 0;;

let g1 = [|[1;4];[0;2;4;7];[1;5];[6;8];
         [0;1];[2;7;8];[3;8];[1;5;8];
         [3;5;6;7];[]|];;

dfs ouvre ferme g1 5;;

let bfs traitement g x0 =
  let n = Array.length g in
  let ouverts = Queue.create () in
  let vus = Array.make n false in
  Queue.push x0 ouverts ;
  vus.(x0) <- true ;
  while not (Queue.is_empty ouverts) do
    let x = Queue.pop ouverts in
    traitement x;
    List.iter 
      (fun y -> if not vus.(y) then
        begin 
          Queue.push y ouverts;
          vus.(y)<-true
        end;) 
      g.(x)
  done;
;;

bfs ouvre g0 0;;
bfs ouvre g1 5;;

exception Trouve;

let accessible g x y =
  let n = Array.length g in
  let vus = Array.make n false in
  let rec explorer x1 =
    if x1 = y then raise Trouve;
    if not vus.(x1) then
      begin
        vus.(x1) <- true;
        List.iter explorer g.(x1);
      end
  in
  try
    explorer x;
    false
  with
  |Trouve -> true
;;

accessible g1 7 8;;

let tab_composante g =
  let n = Array.length g in
  let t = Array.make n (-1) in
  let rec assigne valeur s =
    if t.(s) = -1 then
      begin
        t.(s) <- valeur;
        List.iter (assigne valeur) g.(s)
      end
  in
  for i=0 to n-1 do
    assigne i i
  done;
  t
;;

let liste_composantes g =
  let n = Array.length g in
  let vus = Array.make n false in
  let composantes = ref [] in
  let c = ref [] in 
  let rec listage s =
    if not vus.(s) then
      begin
        vus.(s) <- true;
        c := s :: !c;
        List.iter listage g.(s)
      end
  in
  for i=0 to n-1 do
    if not vus.(i) then
      begin
        c := [];
        listage i;
        composantes := !c :: !composantes
      end
  done;
  composantes
;;

liste_composantes g0;;

let arbre_dfs g x0 =
  let n = Array.length g in
  let vus = Array.make n false in
  let t = Array.make n (-1) in
  let rec explorer x pred =
    if not vus.(x) then
      begin
        vus.(x) <- true;
        t.(x) <- pred;
        List.iter (fun y -> explorer y x) g.(x);
      end
  in
  explorer x0 x0;
  t;
;;

arbre_dfs g0 0;;

let arbre_bfs g x0 =
  let n = Array.length g in
  let ouverts = Queue.create () in
  let vus = Array.make n false in
  let t = Array.make n (-1) in
  Queue.push x0 ouverts ;
  vus.(x0) <- true ;
  t.(x0) <- x0;
  while not (Queue.is_empty ouverts) do
    let x = Queue.pop ouverts in
    List.iter 
      (fun y -> if not vus.(y) then
        begin 
          Queue.push y ouverts;
          vus.(y)<-true;
          t.(y) <- x
        end;) 
      g.(x)
  done;
  t;
;;

arbre_bfs g0 0;;