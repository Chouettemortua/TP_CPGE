let rec est_croissante l =
  match l with
  | [] -> true
  | [x] -> true
  | x::y::ys -> 
    if x<y then est_croissante (y::ys)
    else false
;;

let prefixe x l = List.map (fun y -> x::y) l;;

let rec sous_sequences l =
  match l with
  |[] -> [[]]
  | x::xs ->
    let sous_seq = sous_sequences xs in
    let x_sous_seq = prefixe x sous_seq in
    x_sous_seq@sous_seq
;;

sous_sequences([8;3;5])

let rec max_list l =
  match l with
  | [] -> min_int
  | [x] -> x 
  | x::xs -> max x (max_list xs)
;;

assert(max_list [1;2;3;4;5] = 5)

let l_seq_naif s =
  let sous_seq = sous_sequences s in
  let sous_seq_crois = List.filter (fun x -> est_croissante x) sous_seq in
  let len_sous_seq = List.map (fun x -> List.length x) sous_seq_crois in
  max_list len_sous_seq
;;

l_seq_naif([8;3;5;4;7;9;45;16;23;12;13;14;15;78;79;76;75]);;


type config = int list array ;;

let top l = 
  match l with
  |[] -> max_int
  |x::xs -> x 
;;

let patience l =
  let configuration = Array.make (List.length l) [] in (*O(n)*)
  match patience with
  |[] -> configuration
  |x::xs ->
    let i = ref 0 in
    while x > top configuration.(!i) do (*O(n²)*)
      i := !i+1;
    done;
    configuration.(!i) <- x::configuration.(!i)

