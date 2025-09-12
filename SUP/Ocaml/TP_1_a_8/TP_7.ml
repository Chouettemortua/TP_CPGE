(*Exercice 1*)

let rec binom k n =
  if k = 0 || k = n then 1
  else
    if k<0||n<k then 0
      else (binom (k-1) (n-1)) + (binom (k) (n-1))
;;

assert(binom 1 10 = 10);;
assert(binom 0 10 = 1);;
assert(binom 11 10 = 0);;
assert(binom (-1) 10 = 0);;
binom 10 30;;


let triangle n =
  let res = Array.make (n+1) [||] in
  for i =0 to n do
    res.(i) <- Array.make (i+1) 0;
    for j=0 to i do
      if j = i || j=0 then
        res.(i).(j) <- 1
      else
        res.(i).(j) <- (res.(i-1).(j-1) + res.(i-1).(j))
    done;
  done;
  res
;;

triangle 15;;

let binom_it k n =
  let tri = triangle n in
  tri.(n).(k)
;;

binom_it 6 13;;


let binom_formul k n =
  let factoriel f =
    if f = 0 then 1
    else
      let res = ref 1 in
      for i=1 to f do
        res := (!res)*i 
      done;
      !res in
  (factoriel n )/ ((factoriel k) * (factoriel (n-k)))
;;
binom_formul 6 13;;

(*Exercice 2*)

let recherche_naif x m =
  let n = Array.length m in
  if n > 0 then
    let res = ref false in
    let p = Array.length (m.(0)) in
    for i=0 to n do
      for j=0 to p do
        if x = m.(i).(j) then res := true
      done;
    done;
    !res
  else false
;;
