type ('a, 'b) arbre =
  |Interne of 'a * ('a,'b) arbre * ('a,'b) arbre
  |Feuille of 'b
;;

let exemple_1 =
  Interne(12,
          Interne(4,
            Interne(7,Feuille 20, Feuille 30),
            Interne(14,Feuille 1, Feuille 2)),
          Feuille 20)
;;

let exemple_2 =
  Interne(4,
          Feuille 0.3,
          Interne(1,
            Interne(8,
              Interne(2,
                Feuille 2.5,
                Feuille 3.1),
              Feuille 4.1),
            Feuille 0.2)
          )
;;



let rec hauteur arbre =
  match arbre with
    |Feuille x -> 0
    |Interne (x,arbre_1,arbre_2) -> 
      let h1 = hauteur arbre_1 in
      let h2 = hauteur arbre_2 in
      if h1>h2 then h1+1
      else h2+1
;;

assert(hauteur exemple_2 = 4);;

let rec taille arbre =
  match arbre with
    |Feuille x -> 1
    |Interne (x,arbre_1,arbre_2) -> 
      let t1 = taille arbre_1 in
      let t2 = taille arbre_2 in
      t1+t2+1
;;

assert(taille exemple_2 = 9);;

let rec dernier arbre =
  match arbre with
    |Feuille x -> x
    |Interne (x,arbre_1,arbre_2) -> 
      dernier arbre_2
;;

assert(dernier exemple_2 = 0.2);;

let rec affiche_prefixe arbre =
  match arbre with
  |Feuille x ->
    print_int(x);
    print_newline()
  |Interne (x,arbre_1,arbre_2) ->
    print_int(x);
    print_newline();
    affiche_prefixe arbre_1;
    affiche_prefixe arbre_2
;;

affiche_prefixe exemple_1;;

type ('a, 'b) token = N of 'a | F of 'b ;;

let postfixe arbre =
  let rec aux arbre_b tok_list =
    match arbre_b with
    |Feuille x -> F(x)::tok_list
    |Interne (x,arbre_1,arbre_2) ->
      aux arbre_1 (aux arbre_2 (N(x)::tok_list))  
  in
  aux arbre [];
;;

let rec postfixe_naif arbre =
  match arbre with
  |Feuille x -> [F(x)]
  |Interne (x,arbre_1,arbre_2) -> 
    postfixe_naif arbre_1 @ postfixe_naif arbre_2 @ [N(x)]
;;

assert(postfixe_naif exemple_2 = postfixe exemple_2);;
assert(postfixe exemple_2 = 
[F(0.3);F(2.5);F(3.1);N(2);F(4.1);N(8);F(0.2);N(1);N(4)]);;

let prefixe arbre =
  let rec aux arbre_b tok_list =
    match arbre_b with
    |Feuille x -> F(x)::tok_list
    |Interne (x,arbre_1,arbre_2) ->
      N(x)::aux arbre_1 (aux arbre_2 tok_list)  
  in
  aux arbre [];
;;

assert(prefixe exemple_2 = 
[N(4);F(0.3);N(1);N(8);N(2);F(2.5);F(3.1);F(4.1);F(0.2)]);;

let infixe arbre =
  let rec aux arbre_b tok_list =
    match arbre_b with
    |Feuille x -> F(x)::tok_list
    |Interne (x,arbre_1,arbre_2) ->
      aux arbre_1 (N(x)::aux arbre_2 tok_list)  
  in
  aux arbre [];
;;

assert(infixe exemple_2 = 
[F(0.3);N(4);F(2.5);N(2);F(3.1);N(8);F(4.1);N(1);F(0.2)]);;

let rec lire_etiquette list arbre=
  match list,arbre with
  |[],Interne (x,arbre_1,arbre_2) -> N(x)
  |[],Feuille x -> F(x)
  |false::xs,Interne (x,arbre_1,arbre_2) -> 
    lire_etiquette xs arbre_1
  |true::xs,Interne (x,arbre_1,arbre_2) ->
    lire_etiquette xs arbre_2 
  |_,_ -> failwith "La liste binaire donné ne corespond pas un un neud de l'abre"
;;

assert(lire_etiquette [false;true;false] exemple_1 = F(1));;
assert(lire_etiquette [false] exemple_1 = N(4));;
assert(lire_etiquette [true;false;false;true] exemple_2 = F(3.1));;

let rec increment arbre list =
  match list,arbre with
  |[],Interne (x,arbre_1,arbre_2) -> Interne((x+1),arbre_1,arbre_2)
  |[],Feuille x -> Feuille (x+1)
  |false::xs,Interne (x,arbre_1,arbre_2) -> 
    Interne (x ,(increment arbre_1 xs), arbre_2)
  |true::xs,Interne (x,arbre_1,arbre_2) ->
    Interne (x ,arbre_1, (increment arbre_2 xs))
  |_,_ -> failwith "La liste binaire donné ne corespond pas un un neud de l'abre"
;;
