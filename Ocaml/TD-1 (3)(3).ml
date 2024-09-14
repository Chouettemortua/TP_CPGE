let norme
  a b =  (a*.a +. b*.b)
;;
assert (41. = norme 4. 5.);;
print_newline ();;

let moyenne
  a b = (a +. b)/. 2.
;;
assert (4.= moyenne 3. 5.);;

print_newline ();;

let moyenne_entiers
  a b = float_of_int(a+b)/.2.
;;
assert (7.5 = moyenne_entiers 10 5);;

print_newline ();;

let v_abs a =
  if a<0 then -a
  else a
;;
assert (3 = v_abs (-3));;

print_newline ();;

let rec suite n =
  if n = 0 then 4.
  else 3. *. suite(n-1) +. 2.
;;
assert (134. = suite 3);;

print_newline ();;

let rec fact n =
  if n = 0 then 1
  else n*fact(n-1)
;;
assert (20=fact 4);;

print_newline ();;

let rec somme_carre n =
  if n = 1 then 1
  else n*n+somme_carre(n-1)
;;
assert (30 = somme_carre 4);;

print_newline ();;

let rec puissance x n =
  if n = 0 then 1.
  else x *. puissance x (n-1)
;;
assert (32. = puissance 2. 5);;

print_newline ();;

(*let rec puissancebis x n =
  if n = 0 then 1.
  else puissancebis x (n+1) *. 1. /. x
;;
puissance 10. (-5);;*)

print_newline ();;

let rec somme_liste l =
  match l with
  |  [] -> 0.
  |  x :: xs -> x +. somme_liste xs
;;
assert (6. = somme_liste [1.;2.;3.]);;

print_newline ();;

let rec longueur l =
  match l with
  | [] -> 0
  | x :: xs -> 1 + longueur xs
;;

assert (3 = longueur [1.;2.;3.] );;

print_newline ();;

let rec moyenne_liste l =
  if l = [] then 0.
  else somme_liste l /. float_of_int(longueur l)
;;
assert (4. = moyenne_liste [3.;5.]);;

print_newline ();;

let rec croissant liste =
  match liste with
  | [] -> true
  | [x] -> true
  | x::y::xs -> x<=y && croissant (y::xs)
;;
assert (true = croissant [1;2;3;4]);;

print_newline();;

let rec concat u v =
  match u with
  |[] -> []
  |[x] -> x::v
  | x::xs -> x::concat xs v
;;
assert ([1;2;3;4;5;6] = concat [1;2;3] [4;5;6]);;

print_newline();;

let rec miroir liste =
  match liste with
  |[] -> []
  |x::xs -> miroir xs @ [x]
;;
assert ([3;2;1]=miroir [1;2;3]);;