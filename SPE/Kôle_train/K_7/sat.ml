(* `V i` correspond à la variable propositionnelle d'indice `i` et `NV
   i` à la négation de la variable propositionnelle d'indice `i` *)
type litteral =
  | V of int
  | NV of int

type clause = litteral array

type formule = clause list

type valuation = bool array

(* indice : litteral -> int *)
let indice = function V i | NV i -> i

let initialise (n : int) : valuation =
  Array.init n (fun _ -> Random.int 2 = 0)

let evalue (c : clause) (v : valuation) : bool =
  let rec aux i =
    if i >= Array.length c then
      false
    else
      match c.(i) with
      | V j -> if v.(j) then true else aux (i + 1)
      | NV j -> if not v.(j) then true else aux (i + 1)
  in
  aux 0

(* Objectif : prendre en entrée une formule `f` sur `n` variables, un
   nombre d'essais maximum `k` supposé strictement positif et s'évaluer
   en une option sur une valuation qui satisfait `f` si on en trouve
   une ou `None` si on échoue après `k` tentatives *)
let random_sat (f : formule) (n : int) (k : int) : valuation option =
  assert (k >= 1);
  let v = initialise n in
  let rec test (g : formule)  (k : int) : valuation option =
    match g with
    | [] -> Some v
    | c :: cs ->
       if evalue c v then
         test cs k
       else if k <= 1 || c = [||] then
         None
       else begin
         let i = Random.int (Array.length c) in
         v.(indice c.(i)) <- not v.(indice c.(i));
         test g (k - 1)
       end
  in
  test f k


