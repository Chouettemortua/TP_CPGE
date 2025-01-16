type op =
  |Plus
  |Fois
  |Moins
;;

type expr =
  |C of int
  |N of op*expr*expr
;;

let applique oper x y =
  match oper with
   |Plus -> x+y
   |Fois -> x*y
   |Moins -> x-y
;;

let rec eval calcul =
  match calcul with
  |C x -> x
  |N(oper,gauche,droite) -> 
    applique oper (eval gauche) (eval droite)
;;

applique Moins 2 5;;
applique Fois 4 8;;

let abr = N(Plus,
                (N(Fois,
                    C 4,
                    (N(Moins,
                        C 8,
                        C 9)))),
                (N(Plus,
                    C 6,
                    C 7)))
;;

eval abr;;

type lexeme = PO|PF|Op of op|Val of int;;

let rec prefixe calcul =
  match calcul with
  |C x -> [Val x]
  |N(oper,gauche,droite) ->
    [Op oper]@prefixe(gauche)@prefixe(droite)
;;

let rec postfixe calcul =
  match calcul with
  |C x -> [Val x]
  |N(oper,gauche,droite) ->
    postfixe(gauche)@postfixe(droite)@[Op oper]
;;

let rec infixe calcul =
  match calcul with
  |C x -> [Val x]
  |N(oper,gauche,droite) ->
    [PO]@infixe(gauche)@[Op oper]@infixe(droite)@[PF]
;;

prefixe abr;;
postfixe abr;;
infixe abr;;

let eval_post expre =
  let rec aux e pile =
    match e,pile with
    |[],[x] -> x
    |Val x::xs, _ -> aux xs (x::pile)
    |Op oper::os, d::g::ps -> aux os ((applique oper g d)::ps)
    |_,_ -> failwith "l'expresio n'est pas bien formée"
  in
  aux expre []
;;

eval_post (postfixe abr);;

(*Non fini*)
let arbre_of_post expre =
  let rec aux e pile =
    match e,pile with
    |[],[x] -> x
    |Val x::xs, _ -> aux xs (C x::pile)
    |Op oper::os, d::g::ps -> aux os ((N(oper,g,d))::ps)
    |_,_ -> failwith "l'expresio n'est pas bien formée"
  in
  aux expre []
;;

arbre_of_post (postfixe abr);;