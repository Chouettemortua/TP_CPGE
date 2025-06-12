(*Ewann Roche: TP noté*)

type arbre =
|Vide
|Feuille of char
|Noeud of arbre*arbre
;;

let rec bien_forme abr =
  match abr with
  | Vide -> true
  | Feuille _ -> true
  | Noeud (Vide, Vide) -> false
  | Noeud (g, d) -> (bien_forme g) && (bien_forme d)
;;

let abr_test_valide = Noeud(Feuille 'a', Noeud(Feuille 'b', Feuille 'c'));;
let abr_test_invalide = Noeud(Feuille 'a', Noeud(Vide, Vide));;

assert(bien_forme abr_test_valide);;
assert(not (bien_forme abr_test_invalide));;

type arbre_code =
| F of char
| N of arbre_code*arbre_code
;;

type bitstream = bool list;;

let rec decode_caractere fluxbits abr_code =
  match fluxbits, abr_code with
  |_, F c -> (c, fluxbits)
  |x::xs, N (g, d) -> 
    if x then decode_caractere xs d
    else decode_caractere xs g
  |[], _ -> failwith "il n'y a pas de première lettre"
;;

let abr_test = N(F 'a', N(F 'b', F 'c'));;

assert(decode_caractere [false;true;false] abr_test= ('a', [true;false]));;
assert(decode_caractere [true;false;true] abr_test = ('b', [true]));;

let string_of_char_list_ u = String.of_seq (List.to_seq u)